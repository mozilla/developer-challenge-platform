class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :language
  has_many :reviews
  has_many :judgings
  
  validates_presence_of :description
  
  scope :shortlisted, where(:shortlisted => true)
  
  def review_score
    return 0.0 if self.reviews.complete.empty?
    self.reviews.sum(:score).to_f / self.reviews.complete.count.to_f
  end
  
  def judge_score
    return 0.0 if self.judgings.complete.empty?
    self.judgings.sum(:score).to_f / self.judgings.complete.count.to_f
  end
end
