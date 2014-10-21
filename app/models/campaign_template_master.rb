class CampaignTemplateMaster < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :template_master
end
