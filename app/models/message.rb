class Message < ActiveRecord::Base
  attr_accessor :recipient_username
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  belongs_to :challenge
  validates_presence_of :body, :subject
end
