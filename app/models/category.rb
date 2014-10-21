class Category < ActiveRecord::Base
  scope :active, -> { where(:is_active => true) }
  validates :name, presence: true
  def isactive
  	return is_active ? "Active" : "Inactive"
  end  
end
