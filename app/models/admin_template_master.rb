class AdminTemplateMaster < ActiveRecord::Base
  belongs_to :admin
  belongs_to :template_master
end
