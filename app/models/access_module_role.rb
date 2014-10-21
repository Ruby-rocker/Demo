class AccessModuleRole < ActiveRecord::Base
  belongs_to :access_module
  belongs_to :role
end
