class Location < ActiveRecord::Base
  acts_as_mappable :default_units => :miles,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  has_many :stores, dependent: :destroy
  accepts_nested_attributes_for :stores

  validates :name, :zipcode, presence: true

  default_scope {order('created_at DESC')}
  scope :active, -> { where(:is_active => true) }

  geocoded_by :zipcode
  after_validation :geocode#, if: ->(obj){ obj.zipcode.present? and obj.zipcode_changed? }

  def isactive
  	return is_active ? "Active" : "Inactive"
  end
end
