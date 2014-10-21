class BeaconRange < ActiveRecord::Base
	has_many :campaign_beacon_ranges
  	has_many :campaigns, through: :campaign_beacon_ranges
  
	scope :active, -> { where(:is_active => true) }
	def isactive
  	return is_active ? "Active" : "Inactive"
  	end 
end
