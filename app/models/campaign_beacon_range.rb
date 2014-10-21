class CampaignBeaconRange < ActiveRecord::Base
	belongs_to :beacon_range
  belongs_to :campaign
end
