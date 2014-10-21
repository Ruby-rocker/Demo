class ContactIbeacon < ActiveRecord::Base
	has_many :ibeacons
	has_many :contacts
end
