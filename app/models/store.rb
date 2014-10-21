class Store < ActiveRecord::Base
  belongs_to :location
  has_many :admins

  has_many :ibeacons
  has_many :campaigns

  has_many :attachments, :as => :attachable, :dependent => :destroy

  validates :name,:location_id, presence: true

  scope :active, -> { where(:is_active => true) }

  def isactive
  	return is_active ? "Active" : "Inactive"
  end

  def images(store_id)
    return attachments.find_by_attachable_id(store_id)
  end
end
