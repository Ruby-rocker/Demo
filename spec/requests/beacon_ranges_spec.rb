require 'rails_helper'

RSpec.describe "BeaconRanges", :type => :request do
  describe "GET /beacon_ranges" do
    it "works! (now write some real specs)" do
      get beacon_ranges_path
      expect(response.status).to be(200)
    end
  end
end
