class Message < ActiveRecord::Base
  attr_accessor :recipient_username
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  validates_presence_of :body, :subject
  validates_presence_of :recipient_username, :on => :create
end
