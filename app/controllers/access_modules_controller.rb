class AccessModulesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_access_module, only: [:show, :edit, :update, :destroy]

  # GET /access_modules
  # GET /access_modules.json
  def index
    @access_modules = AccessModule.all
  end

  # GET /access_modules/1
  # GET /access_modules/1.json
  def show
  end

  # GET /access_modules/new
  def new
    @access_module = AccessModule.new
  end

  # GET /access_modules/1/edit
  def edit
  end

  # POST /access_modules
  # POST /access_modules.json
  def create
    @access_module = AccessModule.new(access_module_params)

    respond_to do |format|
      if @access_module.save
        format.html { redirect_to @access_module, notice: 'Access module was successfully created.' }
        format.json { render :show, status: :created, location: @access_module }
      else
        format.html { render :new }
        format.json { render json: @access_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_modules/1
  # PATCH/PUT /access_modules/1.json
  def update
    respond_to do |format|
      if @access_module.update(access_module_params)
        format.html { redirect_to @access_module, notice: 'Access module was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_module }
      else
        format.html { render :edit }
        format.json { render json: @access_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_modules/1
  # DELETE /access_modules/1.json
  def destroy
    @access_module.destroy
    respond_to do |format|
      format.html { redirect_to access_modules_url, notice: 'Access module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_module
      @access_module = AccessModule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_module_params
      params.require(:access_module).permit(:name, :is_active)
    end
end
