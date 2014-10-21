class AdminRoles < ActiveRecord::Base
belongs_to :role
belongs_to :admin
end