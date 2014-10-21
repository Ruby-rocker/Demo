class StoresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new

    render :partial => "form" if params[:flag]
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    model_name = new_polymorphic_path(params[:flag].constantize) if params[:flag] && params[:flag] != "Admin"

    @store = Store.new(store_params)

    if @store.save
      if params[:flag]
        if params[:flag] == "Admin" && params[:form_type] == 'edit'
          redirect_to edit_admin_registration_path(current_admin)
        elsif  params[:flag] == "Admin" && params[:form_type] == 'new'
            redirect_to new_admin_registration_path
        else
          redirect_to model_name
        end
      else
        respond_to do |format|
          if @store.save
            format.html { redirect_to @store, notice: 'Store was successfully created.' }
            format.json { render :show, status: :created, location: @store }
          else
            format.html { render :new }
            format.json { render json: @store.errors, status: :unprocessable_entity }
          end
        end
      end

    else
      render :new
    end

  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :location_id, :is_active)
    end
end
