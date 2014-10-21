require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe BeaconRangesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # BeaconRange. As you add validations to BeaconRange, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BeaconRangesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all beacon_ranges as @beacon_ranges" do
      beacon_range = BeaconRange.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:beacon_ranges)).to eq([beacon_range])
    end
  end

  describe "GET show" do
    it "assigns the requested beacon_range as @beacon_range" do
      beacon_range = BeaconRange.create! valid_attributes
      get :show, {:id => beacon_range.to_param}, valid_session
      expect(assigns(:beacon_range)).to eq(beacon_range)
    end
  end

  describe "GET new" do
    it "assigns a new beacon_range as @beacon_range" do
      get :new, {}, valid_session
      expect(assigns(:beacon_range)).to be_a_new(BeaconRange)
    end
  end

  describe "GET edit" do
    it "assigns the requested beacon_range as @beacon_range" do
      beacon_range = BeaconRange.create! valid_attributes
      get :edit, {:id => beacon_range.to_param}, valid_session
      expect(assigns(:beacon_range)).to eq(beacon_range)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BeaconRange" do
        expect {
          post :create, {:beacon_range => valid_attributes}, valid_session
        }.to change(BeaconRange, :count).by(1)
      end

      it "assigns a newly created beacon_range as @beacon_range" do
        post :create, {:beacon_range => valid_attributes}, valid_session
        expect(assigns(:beacon_range)).to be_a(BeaconRange)
        expect(assigns(:beacon_range)).to be_persisted
      end

      it "redirects to the created beacon_range" do
        post :create, {:beacon_range => valid_attributes}, valid_session
        expect(response).to redirect_to(BeaconRange.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved beacon_range as @beacon_range" do
        post :create, {:beacon_range => invalid_attributes}, valid_session
        expect(assigns(:beacon_range)).to be_a_new(BeaconRange)
      end

      it "re-renders the 'new' template" do
        post :create, {:beacon_range => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested beacon_range" do
        beacon_range = BeaconRange.create! valid_attributes
        put :update, {:id => beacon_range.to_param, :beacon_range => new_attributes}, valid_session
        beacon_range.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested beacon_range as @beacon_range" do
        beacon_range = BeaconRange.create! valid_attributes
        put :update, {:id => beacon_range.to_param, :beacon_range => valid_attributes}, valid_session
        expect(assigns(:beacon_range)).to eq(beacon_range)
      end

      it "redirects to the beacon_range" do
        beacon_range = BeaconRange.create! valid_attributes
        put :update, {:id => beacon_range.to_param, :beacon_range => valid_attributes}, valid_session
        expect(response).to redirect_to(beacon_range)
      end
    end

    describe "with invalid params" do
      it "assigns the beacon_range as @beacon_range" do
        beacon_range = BeaconRange.create! valid_attributes
        put :update, {:id => beacon_range.to_param, :beacon_range => invalid_attributes}, valid_session
        expect(assigns(:beacon_range)).to eq(beacon_range)
      end

      it "re-renders the 'edit' template" do
        beacon_range = BeaconRange.create! valid_attributes
        put :update, {:id => beacon_range.to_param, :beacon_range => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested beacon_range" do
      beacon_range = BeaconRange.create! valid_attributes
      expect {
        delete :destroy, {:id => beacon_range.to_param}, valid_session
      }.to change(BeaconRange, :count).by(-1)
    end

    it "redirects to the beacon_ranges list" do
      beacon_range = BeaconRange.create! valid_attributes
      delete :destroy, {:id => beacon_range.to_param}, valid_session
      expect(response).to redirect_to(beacon_ranges_url)
    end
  end

end
