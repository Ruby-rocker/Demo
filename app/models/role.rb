class Role < ActiveRecord::Base
  has_many :admin_roles
  has_many :admins, :through => :admin_roles
  
  has_many :access_module_roles, :dependent => :destroy
  has_many :access_modules, through: :access_module_roles

  default_scope {order('created_at DESC')}
  scope :active, -> { where(:is_active => true).order(:name) }

  validates :name,   presence: true
  validates_presence_of :access_module_ids

  def isactive
  	return is_active ? "Active" : "Inactive"
  end
  def abc
    abort access_module_ids.to_s
  end
end
