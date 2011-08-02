class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :level
  belongs_to :category
  belongs_to :platform
  belongs_to :duration
  has_many :attempts
  
  validates_presence_of :title, :abstract, :level_id, :category_id, :platform_id, :user_id
  
  scope :community, where(:source => 'community')
  scope :active, where(:state => 'active')
  scope :finished, where(:state => 'finished')
  scope :featured, where(:feature => true)
  
  state_machine :initial => :pending do
    after_transition :on => :activate, :do => :after_activate

    event :activate do
      transition [:pending] => :active
    end
    event :judge do
      transition [:active] => :judging
    end
    event :finish do
      transition [:judging] => :finished
    end
    event :cancel do
      transition [:pending] => :cancelled
    end
  end
  
  def active?
    self.state == 'active'
  end
  
  def open?
    self.active? #and Time.now.utc > self.starts_at and Time.now.utc < self.ends_at
  end
  
  def days_remaining
    return 0 if self.ends_at < Time.now.utc
    return ((self.ends_at - Time.now.utc) / 1.day).round
  end
  
  def to_param
    "#{self.id}-#{self.title.gsub(/[^[:alnum:]]/, '-').downcase}"
  end
  
  def ends_at
    self.activated_at + self.duration.duration
  end
  
  def feature!
    Challenge.featured.each{|x| x.update_attribute(:feature, false)}
    self.update_attribute(:feature, true)
  end
  
  private
    def after_activate
      self.update_attribute(:activated_at, Time.now.utc)
      feature!
    end
  
end
