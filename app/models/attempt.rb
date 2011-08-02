class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :language
  
  validates_presence_of :description
end
