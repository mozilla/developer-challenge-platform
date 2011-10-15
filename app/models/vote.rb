class Vote < ActiveRecord::Base
  belongs_to :attempt, :counter_cache => true
  belongs_to :user
end
