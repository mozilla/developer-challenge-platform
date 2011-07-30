class Profile < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :username, :name
  validates_uniqueness_of :username
end
