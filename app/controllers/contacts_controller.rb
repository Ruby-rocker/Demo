class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:send_push_notification]
  include ActionView::Helpers::DateHelper

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_multiple_contact
    params[:contact][:chk_ids].each do |idx, val|
      if val=='1'
        @contact = Contact.find(idx) rescue ""
        @contact.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contacts were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_push_notification
    @send_notification = false
    @send_limited_campaign = @send_second_welcome_campaign = true

    if params[:send_notification]
      @send_notification = params[:send_notification]
      @built_contact_hash = {:uuid => (params[:uuid] rescue nil), :udid => params[:udid], :first_name => (params[:first_name] rescue nil), :last_name => (params[:last_name] rescue nil), :email_address => (params[:email_address] rescue nil), :contact_no => (params[:contact_no] rescue nil), :latitude => (params[:latitude] rescue nil), :longitude => (params[:longitude] rescue nil)}

      @ibeacon = (Ibeacon.find_by_uuid_and_major_id_and_minor_id(params[:uuid], params[:major], params[:minor]) rescue nil)

      @beacon_range = (BeaconRange.find_by_range(params[:range]) rescue nil)

      @campaign = @ibeacon.campaigns.joins({beacon_ranges: :campaign_beacon_ranges}).where('campaigns.is_active = ?', true).uniq
      @campaign = @campaign.where('beacon_ranges.id = ?', @beacon_range.id) if @beacon_range

      @campaign = @campaign.last
      @campaign_rule = (@campaign.campaign_rule rescue nil)

      @contact = Contact.find_by(:udid => params[:udid])
      @build_contact = (!@contact) ? Contact.create(@built_contact_hash) : @contact rescue nil

      @message_delay = @next_second = @next_min = @next_hour = 0
      # Check rules
      if @campaign_rule
        @sent_campaigns = @campaign.campaign_contacts.where('campaign_contacts.created_at >= ?', @campaign_rule.created_at)
        if @sent_campaigns.count > 0
          @last_sent_campaign = @campaign.campaign_contacts.last

          if @campaign.is_welcome
            @next_welcm_min = ((@campaign_rule.second_welcome_min)*60 rescue 0)
            @next_welcm_hour = ((@campaign_rule.second_welcome_hour)*3600 rescue 0)
            @second_welcome = (@next_welcm_min+@next_welcm_hour rescue 0)
            @next_welcome = (@last_sent_campaign.created_at + @second_welcome.seconds rescue 0)
            @send_second_welcome_campaign = (@next_welcome<DateTime.now.utc) ? true : false
            @message_delay = (@send_second_welcome_campaign) ? 0 : @second_welcome
          else
            #@message_delay_second = (@campaign_rule.message_delay_second rescue 0)
            #@message_delay_min = ((@campaign_rule.message_delay_min)*60 rescue 0)
            #@message_delay_hour = ((@campaign_rule.message_delay_hour)*3600 rescue 0)
            #@message_delay = (@message_delay_second + @message_delay_min + @message_delay_hour rescue 0)

            if @campaign_rule.campaign_limit_message && @campaign_rule.campaign_limit_message != 0
              if @campaign_rule.campaign_limit_days && @campaign_rule.campaign_limit_days!=0
                @previous_limit_campaign = @last_sent_campaign.created_at-@campaign_rule.campaign_limit_days.days
                @message_delay = (@campaign_rule.campaign_limit_days.seconds rescue 0) if @campaign_rule.campaign_limit_days
              else
                @next_second = (@campaign_rule.campaign_limit_second rescue 0) if @campaign_rule.campaign_limit_second
                @next_min = ((@campaign_rule.campaign_limit_min)*60 rescue 0) if @campaign_rule.campaign_limit_min
                @next_hour = ((@campaign_rule.campaign_limit_hour)*3600 rescue 0) if @campaign_rule.campaign_limit_hour
                @next_campaign = (@next_second + @next_min + @next_hour rescue 0)

                @previous_limit_campaign = @last_sent_campaign.created_at-@next_campaign.seconds
                @message_delay = @next_campaign
              end

              @total_sent_campaigns = Campaign.select('campaign_contacts.*').joins(:campaign_contacts, :campaign_rule).where('campaign_rules.created_at < campaign_contacts.created_at AND campaign_contacts.created_at BETWEEN ? AND ?', @previous_limit_campaign, @last_sent_campaign.created_at )

              @send_limited_campaign = (@total_sent_campaigns.count < @campaign_rule.campaign_limit_message) ? true : false
              @message_delay = (@send_limited_campaign) ? 0 : @message_delay
            end

          end
          @message_delay = (DateTime.now > @message_delay.seconds.from_now) ? 0 : @message_delay
        end
      end
      # EOCheck rules

      @template = (TemplateMaster.find(@campaign.campaign_template_masters[0].template_master_id) rescue nil)
      @attachment = @template.images(@template.id) if @template

      if @build_contact
        ContactIbeacon.create!(:contact_id => @build_contact.id, :ibeacon_id => @campaign.ibeacon.id)
        CampaignContact.create!(:contact_id => @build_contact.id, :campaign_id => @campaign.id)
      end

      if @attachment && @send_limited_campaign && @send_second_welcome_campaign && (@send_notification || @send_notification == "true")
        if @message_delay!=0
          Push::MessageApns.delay(run_at: @message_delay.seconds.from_now).create(
              app: 'pushtest',
              device: params[:udid],
              alert: (@campaign.description rescue 'no message'),
              sound: nil,
              badge: @attachment.id,
              expiry: 1.day.to_i,
              attributes_for_device: {key: 'MSG'})
        else
          Push::MessageApns.create(
              app: 'pushtest',
              device: params[:udid],
              alert: (@campaign.description rescue 'no message'),
              sound: nil,
              badge: @attachment.id,
              expiry: 1.day.to_i,
              attributes_for_device: {key: 'MSG'})
        end

        render :json => {:status => 'Success'}
      else
        render :json => {:status => 'campaign not found or send_notification is false'}
      end
    else
      render :json => {:status => 'send_notification not found'}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:uuid, :udid, :first_name, :last_name, :email_address, :contact_no, :latitude, :longitude)
  end
end

