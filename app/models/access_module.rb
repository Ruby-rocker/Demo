class AccessModule < ActiveRecord::Base
  has_many :access_module_roles
  has_many :roles, through: :access_module_roles

  scope :active, -> { where(:is_active => true) }
  def isactive
  	return is_active ? "Active" : "Inactive"
  end  
end
