class Ability
  include CanCan::Ability

  def initialize(admin)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :create, :read, :update, :destroy, :to => :crud

    admin ||= Admin.new # guest user (not logged in)
    if admin.is_superadmin?
      can :crud, :all
    else
      ar = AdminRoles.find_by_admin_id(admin.id)
      AccessModuleRole.where(:role_id => ar.role_id).each do |chk_roles|
        case chk_roles.access_module.name
          when "Campaign"
            can :crud, Campaign
          when "iBeacon"
            can :crud, Ibeacon
          when "Template"
            can :crud, TemplateMaster
        end
      end
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
