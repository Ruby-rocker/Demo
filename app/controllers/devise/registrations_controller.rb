class Devise::RegistrationsController < DeviseController
  before_filter :super_admin_only, only: [ :new, :create ]
  prepend_before_filter :require_no_authentication, only: [ :cancel ]
  #prepend_before_filter :require_no_authentication, only: [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

  def super_admin_only
    redirect_to root_url if (current_admin && !current_admin.is_superadmin?) || !current_admin
  end

  # GET /resource/sign_up
  def new
    build_resource({})

    @address = self.resource.build_address
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.password = Devise.friendly_token.first(8)
    @address = resource.build_address

    resource_saved = resource.save

    yield resource if block_given?
    
    if resource_saved
      resource.create_address if resource.address.blank?
      resource.address.update_attributes(:street => params[:admin][:address][:street], :suit => params[:admin][:address][:suit], :city => params[:admin][:address][:city], :state => params[:admin][:address][:state], :country => params[:admin][:address][:country], :zip_code => params[:admin][:address][:zip_code]) if params[:admin][:address]
      resource.attachments.create(:attachment => params[:admin][:attachment]) if params[:admin][:attachment]
      AdminRoles.create!(:role_id => params[:role_id], :admin_id => resource.id) if params[:role_id]
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        #sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    @admin = Admin.find(params[:format])
    @image = @admin.attachments.find_by(:attachable_id => @admin.id)
    @address = @admin.address
    if !@address
      @address = @admin.build_address
    elsif @address.country && @address.country!=''
      @country = Country.find_country_by_alpha2(@address.country)
      @states = @state = Array.new
      @country.states.each do |idx, key|
        @state << key["name"] if key["name"]
      end
      @states = @state
    end
    @admin_role = AdminRoles.find_by(:admin_id => @admin.id)
    @role = Role.find(@admin_role.role_id) if @admin_role
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    @admin = Admin.find(params[:admin][:id])
    self.resource = @admin

    @address = resource.address
    @address = resource.build_address if !@address

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      AdminRoles.create!(:role_id => params[:role_id], :admin_id => resource.id) if params[:role_id]
      if params[:role_id]
        AdminRoles.where(:admin_id => resource.id).destroy_all
        AdminRoles.create!(:role_id => params[:role_id], :admin_id => resource.id)
      end
      if params[:admin][:attachment]
        resource.attachments.destroy_all if resource.attachments
        resource.attachments.create(:attachment => params[:admin][:attachment])
      end
      resource.address.update_attributes(:street => params[:admin][:address][:street], :suit => params[:admin][:address][:suit], :city => params[:admin][:address][:city], :state => params[:admin][:address][:state], :country => params[:admin][:address][:country], :zip_code => params[:admin][:address][:zip_code]) if params[:admin][:address]
      #end
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  def remove_multiple
    params[:admin][:chk_ids].each do |idx, val|
      if val=='1'
        @admin = Admin.find(idx)
        if params[:admin][:name] == "delete"
          @admin.admin_roles.destroy_all if @admin.admin_roles && @admin.admin_roles.count>0 rescue ""
          @admin.admin_template_masters.destroy_all if @admin.admin_template_masters rescue ""
          @admin.attachments.destroy_all if @admin.attachments rescue ""
          @admin.address.destroy if @admin.address rescue ""
          @admin.destroy
        else
          @admin.is_active = (@admin.is_active?)? false : true
          @admin.save
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Admin were successfully updated.' }
      format.json { head :no_content }
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
        resource.pending_reconfirmation? &&
        previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
   sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    #scope = Devise::Mapping.find_scope!(resource)
    #router_name = Devise.mappings[scope].router_name
    #context = router_name ? send(router_name) : self
    #context.respond_to?(:root_path) ? context.root_path : "/"
    after_sign_in_path_for(resource)
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :first_name, :middle_name, :last_name, :admin_type, :title_id, :suffix, :dob, :gender, :mobile_no, :landline_no, :is_active, attachments_attributes: [:attachment], address_attributes: [:address]) }
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:login, :username, :email, :password, :password_confirmation, :current_password, :first_name,:middle_name, :last_name, :admin_type, :title_id, :suffix, :dob, :gender, :mobile_no, :landline_no, :is_active, attachments_attributes: [:attachment], address_attributes: [:address]) }
  end
end