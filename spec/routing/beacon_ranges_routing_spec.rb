require "rails_helper"

RSpec.describe BeaconRangesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/beacon_ranges").to route_to("beacon_ranges#index")
    end

    it "routes to #new" do
      expect(:get => "/beacon_ranges/new").to route_to("beacon_ranges#new")
    end

    it "routes to #show" do
      expect(:get => "/beacon_ranges/1").to route_to("beacon_ranges#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/beacon_ranges/1/edit").to route_to("beacon_ranges#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/beacon_ranges").to route_to("beacon_ranges#create")
    end

    it "routes to #update" do
      expect(:put => "/beacon_ranges/1").to route_to("beacon_ranges#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/beacon_ranges/1").to route_to("beacon_ranges#destroy", :id => "1")
    end

  end
end
