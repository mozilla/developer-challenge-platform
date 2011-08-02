class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :attempt
  belongs_to :challenge
  scope :pending, where('score IS NULL')
  scope :complete, where('score IS NOT NULL')
end
