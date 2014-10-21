require 'rails_helper'

RSpec.describe "TemplateMasters", :type => :request do
  describe "GET /template_masters" do
    it "works! (now write some real specs)" do
      get template_masters_path
      expect(response.status).to be(200)
    end
  end
end
