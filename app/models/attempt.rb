class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  
  validates_presence_of :description
end
