class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

  attr_accessor :login, :full_name

  validates :username, :uniqueness => {
                          :case_sensitive => false
                        }
  validates :username, :email, :first_name, :middle_name, :last_name, :admin_type, :store_id, :title_id, presence: true
  validates_inclusion_of  :is_active, :in => [true, false]

  belongs_to :store

  has_many :admin_roles#, dependent: :destroy
  has_one :role, :through => :admin_roles

  has_many :admin_template_masters#, dependent: :destroy
  has_many :template_masters, :through => :admin_template_masters

  has_many :attachments, :as => :attachable#, :dependent => :destroy

  has_one :title
  has_one :address#, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  SUPERADMIN = 'super admin'
  ADMIN = 'admin'
  USER = 'user'

  ADMIN_TYPE = {SUPERADMIN => 'super admin', ADMIN => 'admin', USER => 'user'}

  scope :active, -> { where(:is_active => true) }
  scope :superadmin, where(admin_type: SUPERADMIN)
  scope :admin, where(admin_type: ADMIN)
  scope :user, where(admin_type: USER)

  validates :admin_type, inclusion: { in: [ SUPERADMIN, ADMIN, USER ] }

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def show_name
    @name = [first_name, last_name].join(' ')
    @name = username.titlecase if @name.strip == ""
    return @name
  end

  def is_superadmin?
    admin_type.eql? SUPERADMIN
  end

  def is_admin?
    admin_type.eql? ADMIN
  end

  def is_user?
    admin_type.eql? USER
  end

  def user_type
    case admin_type
      when SUPERADMIN
        'Super Admin'
      when ADMIN
        'Admin'
      when USER
        'User'
    end
  end

  def isactive
    return is_active ? "Active" : "Inactive"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
