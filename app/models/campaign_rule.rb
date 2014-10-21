class CampaignRule < ActiveRecord::Base
  belongs_to :campaign
  default_scope {order('created_at DESC')}
end
