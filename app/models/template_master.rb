class TemplateMaster < ActiveRecord::Base
  has_many :attachments, :as => :attachable, :dependent => :destroy

  has_many :admin_template_masters
  has_many :admins, :through => :admin_template_masters

  has_many :campaign_template_masters
  has_many :template_masters, through: :campaign_template_masters

  validates :name,  presence: true

  default_scope {order('created_at DESC')}
  scope :active, -> { where(:is_active => true) }

  def isactive
  	return is_active ? "Active" : "Inactive"
  end

  def images(template_id)
    return attachments.find_by_attachable_id(template_id)
  end
end
