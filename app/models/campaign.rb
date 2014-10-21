class Campaign < ActiveRecord::Base
  belongs_to :store
  belongs_to :ibeacon
  belongs_to :category

  has_many :campaign_beacon_ranges
  has_many :beacon_ranges, through: :campaign_beacon_ranges

  has_many :campaign_template_masters
  has_many :template_masters, through: :campaign_template_masters
  has_many :attachments, :as => :attachable, :dependent => :destroy

  has_many :campaign_contacts
  has_many :contacts, through: :campaign_contacts

  has_one :campaign_rule

  validates :title, :description,  presence: true
  validates_presence_of :store_id, :ibeacon_id, :category_id

  default_scope {order('created_at DESC')}
  scope :active, -> { where(:is_active => true) }

  def isactive
  	return is_active ? 'Active' : 'Inactive'
  end

    def self.deactivate_campaign
    Campaign.joins(:campaign_rule).active.each do |campaign|
      @campaign_rule = campaign.campaign_rule
      @deactivate_days = @campaign_rule.deactivate_campaign

      #start counting from campaign created date
      #@deactivate_date = (campaign.created_at+@deactivate_days.days).to_formatted_s(:db)

      #start counting from rule created date
      @deactivate_date = (@campaign_rule.created_at+@deactivate_days.days).to_formatted_s(:db)

      @current_date = DateTime.now.to_formatted_s(:db)
      if @deactivate_date <= @current_date
        campaign.is_active = false
        campaign.save!
        puts "#{campaign.id} changed"
      end
      puts "#{campaign.id} not changed"
    end
    puts 'Outside each loop'
  end

end
