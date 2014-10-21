require "spec_helper"

describe AccessModulesController do
  describe "routing" do

    it "routes to #index" do
      get("/access_modules").should route_to("access_modules#index")
    end

    it "routes to #new" do
      get("/access_modules/new").should route_to("access_modules#new")
    end

    it "routes to #show" do
      get("/access_modules/1").should route_to("access_modules#show", :id => "1")
    end

    it "routes to #edit" do
      get("/access_modules/1/edit").should route_to("access_modules#edit", :id => "1")
    end

    it "routes to #create" do
      post("/access_modules").should route_to("access_modules#create")
    end

    it "routes to #update" do
      put("/access_modules/1").should route_to("access_modules#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/access_modules/1").should route_to("access_modules#destroy", :id => "1")
    end

  end
end
