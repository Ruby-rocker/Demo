class Ibeacon < ActiveRecord::Base
  belongs_to :store

  has_many :campaigns, :dependent => :destroy
  has_many :contacts, primary_key: 'uuid', foreign_key: 'uuid', dependent: :destroy

  validates :name, :store_id, :broadcast_id, :uuid, :major_id, :minor_id,  presence: true

  default_scope {order('created_at DESC')}
  scope :active, -> { where(:is_active => true) }

  has_many :contact_ibeacons
  has_many :contacts, through: :contact_ibeacons

  def isactive
  	return is_active ? "Active" : "Inactive"
  end  
end
