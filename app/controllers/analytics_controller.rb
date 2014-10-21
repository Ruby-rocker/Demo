class AnalyticsController < ApplicationController
	before_action :authenticate_admin!


  def index
    c = current_admin.store.campaigns
    session[:campaign_id] = Array.new
    c.each do |c|
      session[:campaign_id] << c.id
    end
    @contacts = CampaignContact.where("campaign_id IN (?)",session[:campaign_id])
    @contacts_daily = @contacts.group("DATE(created_at)").count
    @contacts_month = CampaignContact.where("campaign_id IN (?)",session[:campaign_id])
    @contacts_month = @contacts_month.group_by { |t| t.created_at.month }
    @contacts_week = @contacts.group_by(&:week)
    @week_count = Array.new
    @week = Array.new
    @contacts_week.each do |index, week|
      @week_count << week.count
      @week << index
    end
    @month_count = Array.new
    @month_name = Array.new
    @contacts_month.each do |index, month|
      @month_count << month.count
      @month_name << Date::MONTHNAMES[index]
    end
    @count = Array.new
    @date = Array.new
    @contacts_daily.each do |index, value|
      @count << value
      @date << index.to_s
    end
    @store = Store.all
  end
end
