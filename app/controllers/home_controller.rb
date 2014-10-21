class HomeController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = current_admin.show_name
    @location = Location.new
    @location.stores.present? || @location.stores.build
    @campaigns = Campaign.all.order("id desc").limit(5)
    #@campaigns = Campaign.all.order(sort_column_campaign + " " + sort_direction_campaign).limit(5)
    @ibeacons =  Ibeacon.all.order("id desc").limit(5)
  end

end
