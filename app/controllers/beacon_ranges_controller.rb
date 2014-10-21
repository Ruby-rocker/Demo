class BeaconRangesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_beacon_range, only: [:show, :edit, :update, :destroy]

  # GET /beacon_ranges
  # GET /beacon_ranges.json
  def index
    @beacon_ranges = BeaconRange.all
  end

  # GET /beacon_ranges/1
  # GET /beacon_ranges/1.json
  def show
  end

  # GET /beacon_ranges/new
  def new
    @beacon_range = BeaconRange.new
  end

  # GET /beacon_ranges/1/edit
  def edit
  end

  # POST /beacon_ranges
  # POST /beacon_ranges.json
  def create
    @beacon_range = BeaconRange.new(beacon_range_params)

    respond_to do |format|
      if @beacon_range.save
        format.html { redirect_to @beacon_range, notice: 'Beacon range was successfully created.' }
        format.json { render :show, status: :created, location: @beacon_range }
      else
        format.html { render :new }
        format.json { render json: @beacon_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beacon_ranges/1
  # PATCH/PUT /beacon_ranges/1.json
  def update
    respond_to do |format|
      if @beacon_range.update(beacon_range_params)
        format.html { redirect_to @beacon_range, notice: 'Beacon range was successfully updated.' }
        format.json { render :show, status: :ok, location: @beacon_range }
      else
        format.html { render :edit }
        format.json { render json: @beacon_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beacon_ranges/1
  # DELETE /beacon_ranges/1.json
  def destroy
    @beacon_range.destroy
    respond_to do |format|
      format.html { redirect_to beacon_ranges_url, notice: 'Beacon range was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beacon_range
      @beacon_range = BeaconRange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beacon_range_params
      params.require(:beacon_range).permit(:name, :is_active)
    end
end
