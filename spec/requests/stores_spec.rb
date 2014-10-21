require 'rails_helper'

RSpec.describe "Stores", :type => :request do
  describe "GET /stores" do
    it "works! (now write some real specs)" do
      get stores_path
      expect(response.status).to be(200)
    end
  end
end
