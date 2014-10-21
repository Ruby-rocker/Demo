class IbeaconsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_ibeacon, only: [:show, :edit, :update, :destroy]

  # GET /ibeacons
  # GET /ibeacons.json
  def index
    @ibeacons = Ibeacon.joins(:store).sorted(params[:sort], "id,stores.name ASC:DESC?ASC")
  end

  # GET /ibeacons/1
  # GET /ibeacons/1.json
  def show
  end

  # GET /ibeacons/new
  def new
    @ibeacon = Ibeacon.new
  end

  # GET /ibeacons/1/edit
  def edit
    @ibeacon_store = (@ibeacon.store rescue "")
    @ibeacon_location = (@ibeacon_store.location rescue "")
    if @ibeacon_location && @ibeacon_location != ""
      @stores = Store.where("location_id = ? ",@ibeacon_location.id).active
    else
      @stores = Store.all.active
    end
  end

  # POST /ibeacons
  # POST /ibeacons.json
  def create
    @ibeacon = Ibeacon.new(ibeacon_params)

    respond_to do |format|
      if @ibeacon.save
        format.html { redirect_to ibeacons_path, notice: 'Ibeacon was successfully created.' }
        format.json { render :index, status: :created, location: @ibeacon }
      else
        format.html { render :new }
        format.json { render json: @ibeacon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ibeacons/1
  # PATCH/PUT /ibeacons/1.json
  def update
    respond_to do |format|
      if @ibeacon.update(ibeacon_params)
        format.html { redirect_to ibeacons_path, notice: 'Ibeacon was successfully updated.' }
        format.json { render :index, status: :ok, location: @ibeacon }
      else
        format.html { render :edit }
        format.json { render json: @ibeacon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ibeacons/1
  # DELETE /ibeacons/1.json
  def destroy
    @ibeacon.destroy
    respond_to do |format|
      format.html { redirect_to ibeacons_url, notice: 'Ibeacon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_multiple_ibeacon
    params[:ibeacon][:chk_ids].each do |idx, val|
      if val=='1'
        @ibeacon = Ibeacon.find(idx)
        if params[:ibeacon][:name] == "delete"
          @ibeacon.campaigns.destroy_all if @ibeacon.campaigns rescue ""
          @ibeacon.destroy
        else
          @ibeacon.is_active = (@ibeacon.is_active?)? false : true
          @ibeacon.save
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to ibeacons_url, notice: 'Ibeacon were successfully updated.' }
      format.json { head :no_content }
    end
  end

  def get_stores
    if params[:id] != "0"
      set_ibeacon
    else
      @ibeacon = Ibeacon.new
    end
    @location_id = params[:location_id]
    @stores = Store.where("location_id = ? ",params[:location_id]).active

    respond_to do |format|
      format.html { render :get_stores, :layout => nil }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ibeacon
      @ibeacon = Ibeacon.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def ibeacon_params
      params.require(:ibeacon).permit(:name, :description, :store_id, :broadcast_id, :uuid, :major_id, :minor_id, :broadcasting_power, :broadcasting_interval, :is_active)
    end
end
