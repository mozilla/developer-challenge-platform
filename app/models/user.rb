class User < ActiveRecord::Base
  has_secure_password
  has_one :profile
  has_many :challenges
  has_many :attempts
  has_many :sent_messages, :foreign_key => 'sender_id', :class_name => 'Message'
  has_many :received_messages, :foreign_key => 'recipient_id', :class_name => 'Message'
  
  before_validation :generate_auth_token, :on => :create
  validates_uniqueness_of :email
  
  delegate :name, :to => :profile
  
  def username
    self.profile ? self.profile.username : self.email.split('@').first
  end
  
  def to_param
    self.username ? self.username : self.id
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
