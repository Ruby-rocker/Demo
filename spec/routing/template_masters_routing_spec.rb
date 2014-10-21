require "rails_helper"

RSpec.describe TemplateMastersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/template_masters").to route_to("template_masters#index")
    end

    it "routes to #new" do
      expect(:get => "/template_masters/new").to route_to("template_masters#new")
    end

    it "routes to #show" do
      expect(:get => "/template_masters/1").to route_to("template_masters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/template_masters/1/edit").to route_to("template_masters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/template_masters").to route_to("template_masters#create")
    end

    it "routes to #update" do
      expect(:put => "/template_masters/1").to route_to("template_masters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/template_masters/1").to route_to("template_masters#destroy", :id => "1")
    end

  end
end
