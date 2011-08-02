class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :language
  has_many :reviews
  
  validates_presence_of :description
  
  def review_score
    return 0.0 if self.reviews.empty?
    self.reviews.sum(:score).to_f / self.reviews.complete.count.to_f
  end
end
