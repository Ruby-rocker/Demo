class CampaignRulesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_campaign_rule, only: [:show, :edit, :update, :destroy]
  #def index
  #  @stores = (current_admin.is_superadmin?) ? Store.active.all : current_admin.store
  #  @beacons = (current_admin.is_superadmin?) ? Ibeacon.active.all : current_admin.store.ibeacons
  #  @campaigns = (current_admin.is_superadmin?) ? Campaign.active.all : current_admin.store.campaigns
  #end

  # GET /campaign_rules
  # GET /campaign_rules.json
  def index
    @campaign_rules = CampaignRule.all
  end

  # GET /campaign_rules/1
  # GET /campaign_rules/1.json
  def show
  end

  # GET /campaign_rules/new
  def new
    @campaign_rule = CampaignRule.new
    @stores = (current_admin.is_superadmin?) ? Store.active.all : current_admin.store
    @beacons = (current_admin.is_superadmin?) ? Ibeacon.active.all : current_admin.store.ibeacons
    @campaigns = (current_admin.is_superadmin?) ? Campaign.active.all : current_admin.store.campaigns
  end

  # GET /campaign_rules/1/edit
  def edit
    @stores = (current_admin.is_superadmin?) ? Store.active.all : current_admin.store
    @beacons = (current_admin.is_superadmin?) ? Ibeacon.active.all : current_admin.store.ibeacons
    @campaigns = (current_admin.is_superadmin?) ? Campaign.active.all : current_admin.store.campaigns
    @current_campaign = (@campaign_rule.campaign rescue nil)
    @current_store = (@current_campaign.store_id rescue nil)
    @current_beacon = (@current_campaign.ibeacon_id rescue nil)
  end

  def create
    @campaign_rule = CampaignRule.new(campaign_rule_params)

    respond_to do |format|
      if @campaign_rule.save
        format.html { redirect_to campaign_rules_path, notice: 'Rule was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /campaign_rules/1
  # PATCH/PUT /campaign_rules/1.json
  def update
    params.permit!
    respond_to do |format|
      if @campaign_rule.update(params[:campaign_rule])
        format.html { redirect_to campaign_rules_path, notice: 'Rule was successfully updated.' }
        format.json { render :index, status: :ok, location: @campaign_rule }
      else
        format.html { render :edit }
        format.json { render json: @campaign_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_beacons
    @destination_view = (params[:destination_page] == 'campaign_rules') ? 'campaign_rules/get_beacons' : 'campaigns/get_beacons'
    @beacons = Ibeacon.where(:store_id => params[:store_id])
    respond_to do |format|
      format.html { render @destination_view, :layout => nil }
    end
  end

  def get_campaigns
    @campaigns = Campaign.where(:ibeacon_id => params[:beacon_id])
    respond_to do |format|
      format.html { render "campaign_rules/get_campaigns", :layout => nil }
    end
  end

  def remove_multiple_campaign_rule
    params[:campaign_rule][:chk_ids].each do |idx, val|
      if val=='1'
        @campaign_rule = CampaignRule.find(idx)
        if params[:campaign_rule][:name] == "delete"
          @campaign_rule.destroy
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to campaign_rules_url, notice: 'Rules were successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def get_rules
    @campaign_rule = CampaignRule.find_by_campaign_id(params[:campaign_id])
    respond_to do |format|
      format.html { render "campaign_rules/get_rules", :layout => nil }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def campaign_rule_params
    params.require(:campaign_rule).permit(:second_welcome_min, :second_welcome_hour, :message_delay_second, :message_delay_min, :message_delay_hour, :campaign_limit_message, :campaign_limit_second, :campaign_limit_min, :campaign_limit_hour, :campaign_limit_days, :deactivate_campaign, :campaign_id)
  end

  def set_campaign_rule
    @campaign_rule = CampaignRule.find(params[:id])
  end

end
