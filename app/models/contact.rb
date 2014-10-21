class Contact < ActiveRecord::Base
  validates :uuid, :udid,  presence: true
  belongs_to :ibeacon, :foreign_key => "uuid", :primary_key => "uuid"

  has_many :campaign_contacts
  has_many :campaigns, through: :campaign_contacts

  has_many :contact_ibeacons
  has_many :ibeacons, through: :contact_ibeacons
end
