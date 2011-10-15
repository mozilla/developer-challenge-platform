class User < ActiveRecord::Base
  has_secure_password
  has_one :profile
  has_many :challenges
  has_many :attempts
  has_many :sent_messages, :foreign_key => 'sender_id', :class_name => 'Message'
  has_many :received_messages, :foreign_key => 'recipient_id', :class_name => 'Message'
  has_many :reviews
  has_many :judgings
  has_many :votes
  
  before_validation :generate_auth_token, :on => :create
  validates_uniqueness_of :email
  
  delegate :name, :to => :profile
  
  attr_accessible :email, :password
  attr_accessible :judge, :admin, :reviewer, :as => :admin
  
  scope :ordinary, where(:admin => false).where(:reviewer => false).where(:judge => false)
  scope :admins, where(:admin => true)
  scope :reviewers, where(:reviewer => true)
  scope :judges, where(:judge => true)
  
  # state_machine :initial => :pending do
  #   # after_transition :on => :activate, :do => :after_activate
  # 
  #   event :activate do
  #     transition [:pending] => :active
  #   end
  #   event :ban do
  #     transition [:active] => :banned
  #   end
  # end
  
  def username
    self.profile ? self.profile.username : self.email.split('@').first
  end
  
  def to_param
    self.username ? self.username : self.id
  end
  
  def reviewing?(attempt)
    self.reviews.where(:attempt_id => attempt.id).first
  end
  
  def judging?(attempt)
    self.judgings.where(:attempt_id => attempt.id).first
  end
  
  private
    def generate_auth_token
      generate_token(:auth_token)
    end
    
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
