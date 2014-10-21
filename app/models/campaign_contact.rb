class CampaignContact < ActiveRecord::Base
	has_many :campaigns
	has_many :contacts
	def week
  		self.created_at.strftime("%W")
	end
	#scope :week, where(self.created_at.strftime("%W"))
end
