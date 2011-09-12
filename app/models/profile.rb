class Profile < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :username, :name
  validates_uniqueness_of :username
  
  def github?
    self.github_token.present?
  end
  
  def twitter?
    self.twitter_token.present?
  end
end
