class CampaignsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction, :sort_by_store

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.joins(:store, :ibeacon, :category).sorted(params[:sort], "id,title,stores.name,ibeacons.name,categories.name ASC:DESC?ASC")
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
    @audios = Attachment.where(:attachable_type => "Campaign") rescue nil
    @store_templates = Attachment.all.where(:attachable_type => "TemplateMaster")

    @my_campaign_templates = @store_templates.joins('inner join template_masters on template_masters.id=attachments.attachable_id').joins('inner join admin_template_masters on template_masters.id=admin_template_masters.template_master_id').joins('inner join admins admins on admins.id=admin_template_masters.admin_id').where("attachments.attachable_type='TemplateMaster' AND admins.id=?", current_admin.id)
  end

  # GET /campaigns/1/edit
  def edit
    @audios = Attachment.where(:attachable_type => "Campaign") rescue nil
    @template_id = @campaign.campaign_template_masters[0].template_master_id if (@campaign.campaign_template_masters && @campaign.campaign_template_masters[0])
    @camp_template = Attachment.where(:attachable_type => "TemplateMaster", :attachable_id => @template_id) rescue nil
    @template_attach_id = @camp_template[0].id rescue ""
    @campaign_store = (@campaign.store rescue "")
    @campaign_beacon = (@campaign.ibeacon rescue "")
    @campaign_location = (@campaign_store.location rescue "")
    if @campaign_location && @campaign_location != ""
      @stores = Store.where("location_id = ? ",@campaign_location.id).active
    else
      @stores = Store.all.active
    end
    @store_ids = Array.new
    @stores.each do |store|
      @store_ids<<store.id
    end
    @beacons = Ibeacon.joins(:store).where("store_id in (?)", @store_ids)
    @store_templates = Attachment.all.where(:attachable_type => "TemplateMaster")
    @my_campaign_templates = @store_templates.joins('inner join template_masters on template_masters.id=attachments.attachable_id').
        joins('inner join admin_template_masters on template_masters.id=admin_template_masters.template_master_id').
        joins('inner join admins admins on admins.id=admin_template_masters.admin_id').
        where("attachments.attachable_type='TemplateMaster' AND admins.id=?", current_admin.id)
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.beacon_range_ids = params[:campaign][:beacon_range_ids]

    if params[:campaign][:template_master_ids]
      @attachment = Attachment.find(params[:campaign][:template_master_ids])
      @templt_mstr = TemplateMaster.find(@attachment.attachable_id)
    end

    respond_to do |format|
      if @campaign.save
        @attachment =  Attachment.create!(:attachment_audio=> params[:campaign][:attachment_audio],:attachable_id => @campaign.id,:attachable_type => 'Campaign') if params[:campaign][:attachment_audio]
        CampaignTemplateMaster.create!(:campaign_id => @campaign.id, :template_master_id => @templt_mstr.id) if @templt_mstr
        format.html { redirect_to campaigns_path, notice: 'Campaign was successfully created.' }
        format.json { render :index, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        @campaign.campaign_beacon_ranges.destroy_all if @campaign.campaign_beacon_ranges
        params[:campaign][:beacon_range_ids].each do |cbr|
          CampaignBeaconRange.create!(:campaign_id => @campaign.id, :beacon_range_id => cbr) if cbr!=""
        end

        if params[:campaign][:template_master_ids]
          @attachment = Attachment.find(params[:campaign][:template_master_ids])
          @templt_mstr = TemplateMaster.find(@attachment.attachable_id)

          @campaign.campaign_template_masters.destroy_all if @campaign.campaign_template_masters

          CampaignTemplateMaster.create!(:campaign_id => @campaign.id, :template_master_id => @templt_mstr.id) if @templt_mstr
        end
        format.html { redirect_to campaigns_path, notice: 'Campaign was successfully updated.' }
        format.json { render :index, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.campaign_beacon_ranges.destroy_all if @campaign.campaign_beacon_ranges  rescue ""
    @campaign.campaign_template_masters.destroy_all if @campaign.campaign_template_masters rescue ""
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_multiple_campaign
    params[:campaign][:chk_ids].each do |idx, val|
      if val=='1'
        @campaign = Campaign.find(idx)
        if params[:campaign][:name] == "delete"
          @campaign.campaign_beacon_ranges.destroy_all if @campaign.campaign_beacon_ranges  rescue ""
          @campaign.campaign_template_masters.destroy_all if @campaign.campaign_template_masters rescue ""
          @campaign.destroy
       else
          @campaign.is_active = (@campaign.is_active?)? false : true
          @campaign.save
       end
      end
    end
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaigns were successfully updated.' }
      format.json { head :no_content }
    end
  end

  def get_stores
    if params[:id] != "0"
      set_campaign
    else
      @campaign = Campaign.new
    end
    @location_id = params[:location_id]
    @stores = Store.where("location_id = ? ",params[:location_id]).active

    respond_to do |format|
      format.html { render :get_stores, :layout => nil }
    end
  end

  def audio
    render :partial => 'audio'
  end

  def create_audio

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      #params.require(:campaign).permit!
      params.require(:campaign).permit(:title, :name, :description,:schedule_from, :schedule_to, :store_id, :ibeacon_id, :category_id, :is_active, :is_welcome, attachments_attributes: [:attachment_audio])
    end
end
