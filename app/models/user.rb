class User < ActiveRecord::Base
  has_secure_password
  before_validation :generate_auth_token, :on => :create
  
  private
    def generate_auth_token
      generate_token(:auth_token)
    end
end
