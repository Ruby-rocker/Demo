class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_admin!

  alias_method :current_user, :current_admin

  before_action :configure_permitted_parameters, if: :devise_controller?

  def get_states
    @country = Country.find_country_by_alpha2(params[:country_id])
    @states = @state = Array.new
    @country.states.each do |idx, key|
      @state << key["name"] if key["name"]
    end

    @states = @state
    respond_to do |format|
      format.html { render "devise/registrations/get_states", :layout => nil }
    end
  end

  def comingsoon
    respond_to do |format|
      format.html { render "layouts/comingsoon" }
    end
  end

  #def remove_multiple
  #  @controller_name = params[:controller_type].singularize
  #  @redirect_path = "#{@controller_name.pluralize}_url"
  #  params[@controller_name][:chk_ids].each do |idx, val|
  #    if val=='1'
  #      @contrler = @controller_name.camelize.classify.constantize.find(idx)
  #      if @controller_name == "role"
  #        @contrler.access_module_roles.destroy_all if @contrler.access_module_roles
  #        @contrler.destroy
  #      elsif @controller_name == "campaign"
  #        @contrler.campaign_beacon_ranges.destroy_all if @contrler.campaign_beacon_ranges
  #        @contrler.campaign_template_masters.destroy_all if @contrler.campaign_template_masters
  #        @contrler.destroy
  #      else
  #        @contrler.destroy
  #      end
  #    end
  #  end
  #  respond_to do |format|
  #    #format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
  #    format.html { redirect_to @redirect_path, notice: 'Records were successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :store_id, :email, :password, :password_confirmation, :remember_me, :first_name, :middle_name, :last_name, :admin_type, :title_id, :suffix, :dob, :gender, :mobile_no, :landline_no, :is_active, attachments_attributes: [:attachment], address_attributes: [:address]) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:login, :username, :store_id, :email, :password, :password_confirmation, :current_password, :first_name,:middle_name, :last_name, :admin_type, :title_id, :suffix, :dob, :gender, :mobile_no, :landline_no, :is_active, attachments_attributes: [:attachment], address_attributes: [:address]) }
  end

end
