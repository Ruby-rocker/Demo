require 'rails_helper'

RSpec.describe "Ibeacons", :type => :request do
  describe "GET /ibeacons" do
    it "works! (now write some real specs)" do
      get ibeacons_path
      expect(response.status).to be(200)
    end
  end
end
