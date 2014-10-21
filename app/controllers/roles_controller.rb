class RolesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all.sorted(params[:sort])
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)
    @role.access_module_ids = params[:role][:access_module_ids]

    respond_to do |format|
      if @role.save
        #params[:role][:access_module_ids].each do |acmi|
        #  AccessModuleRole.create!(:role_id => @role.id, :access_module_id => acmi) if acmi!=""
        #end
        format.html { redirect_to roles_path, notice: 'Role was successfully created.' }
        format.json { render :index, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        @role.access_module_roles.destroy_all
        params[:role][:access_module_ids].each do |acmi|
          AccessModuleRole.create!(:role_id => @role.id, :access_module_id => acmi) if acmi!=""
        end
        format.html { redirect_to roles_path, notice: 'Role was successfully updated.' }
        format.json { render :index, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_multiple
    params[:role][:chk_ids].each do |idx, val|
      if val=='1'
        @role = Role.find(idx)
        if params[:role][:name] == "delete"
          @role.access_module_roles.destroy_all if @role.access_module_roles rescue ""
          @role.destroy
        else
          @role.is_active = (@role.is_active?)? false : true
          @role.save
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Roles were successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    def sort_column
      Role.column_names.include?(params[:sort]) ? params[:sort] : 'id'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name,:chk_ids ,:description, :code, :is_active, :access_module_ids)
    end
end
