class LocationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
    @location.stores.present? || @location.stores.build
    render :partial => "form" if params[:flag]
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    model_name=""
    model_name = new_polymorphic_path(params[:flag].constantize) if params[:flag] && params[:flag]!=""

    @location = Location.new(location_params)

    if @location.save
      mapsApiKey = 'AIzaSyAalhFrTpxZOmu0db_9M4Pj2OYlt3h1FU8'
      query = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@location.zipcode}&sensor=false"

      require 'open-uri'
      file = open(query)
      data = JSON.parse file.read
      @latitude =  data["results"][0]["geometry"]["location"]["lat"]
      @longitude =  data["results"][0]["geometry"]["location"]["lng"]

      @location.latitude = @latitude
      @location.longitude = @longitude
      @location.save

      params[:location][:stores_attributes].each do |key, val|
        @location.stores.create(:name => val[:name], :is_active => true)
      end
      %x(bundle exec rake geocode:all CLASS=Location)
      redirect_to model_name if model_name!=""
      redirect_to root_path
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)

        mapsApiKey = 'AIzaSyCuVnQVdPVtxMyhxkdGDRDquKMfibWpIDc'
        query = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@location.zipcode}&sensor=false"

        require 'open-uri'
        file = open(query)
        data = JSON.parse file.read
        @latitude =  data["results"][0]["geometry"]["location"]["lat"] rescue nil
        @longitude =  data["results"][0]["geometry"]["location"]["lng"] rescue nil
        @location.latitude = @latitude if @latitude
        @location.longitude = @longitude if @longitude
        @location.save if @latitude && @longitude
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_multiple_location
    params[:location][:chk_ids].each do |idx, val|
      if val=='1'
        @location = (Location.find(idx) rescue nil)
        if @location
          if params[:location][:name] == "delete"
            if @location.stores
              @location.stores.each do |store|
                store.ibeacons.destroy_all if store.ibeacons rescue nil
                store.campaigns.destroy_all if store.campaigns rescue nil
                store.attachment_store.destroy if store.attachment_store rescue nil
              end
            end
            @location.destroy
          else
            @location.is_active = (@location.is_active?)? false : true
            @location.save
          end
        end
      elsif params[:store]
        params[:store][:chk_ids].each do |idy, valx|
          if valx=='1'
            @store = (Store.find(idy) rescue nil)
            if @store
              if params[:location][:name] == "delete"
                if @store.ibeacons
                  @store.ibeacons.each do |store|
                    store.ibeacons.destroy_all if store.ibeacons rescue nil
                    store.campaigns.destroy_all if store.campaigns rescue nil
                    store.attachment_store.destroy if store.attachment_store rescue nil
                  end
                end
                @store.campaigns.destroy_all if store.campaigns rescue nil
                @store.attachment_store.destroy if store.attachment_store rescue nil
                @store.destroy
              else
                @store.is_active = (@store.is_active?)? false : true
                @store.save
              end
            end
          elsif params[:ibeacon]
            params[:ibeacon][:chk_ids].each do |idz, valy|
              if valy=='1'
                @ibeacon = (Ibeacon.find(idz) rescue nil)
                if @ibeacon
                  if params[:location][:name] == "delete"
                    ibeacon.campaigns.destroy_all if ibeacon.campaigns rescue nil
                    @ibeacon.destroy
                  else
                    @ibeacon.is_active = (@ibeacon.is_active?)? false : true
                    @ibeacon.save
                  end
                end
              end
            end
          end
        end
      end
    end
      respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Locations were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :zipcode, :latitude, :longitude, :is_active, :stores_attributes)
    end
end
