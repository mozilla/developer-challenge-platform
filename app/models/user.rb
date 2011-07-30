class User < ActiveRecord::Base
  has_secure_password
  has_one :profile
  has_many :challenges
  has_many :attempts
  before_validation :generate_auth_token, :on => :create
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
