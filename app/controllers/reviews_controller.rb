class ReviewsController < ApplicationController
  before_filter :challenge_required
  before_filter :attempt_requried
  before_filter :review_required
  before_filter :reviewer_required
  
  def update
    @review.update_attributes!(params[:review])
    Message.create!( 
      :sender => @review.user, :recipient_username => @review.attempt.user.username, :recipient => @review.attempt.user, 
      :subject => "Review Comment for: #{@review.attempt.challenge.title}", :body => @review.comment
    )
    redirect_to @review.user, :notice => 'Your review has been saved'
  end
  
  private
    def challenge_required
      @challenge = Challenge.find_by_id(params[:challenge_id])
    end
    
    def attempt_requried
      @attempt = @challenge.attempts.find_by_id(params[:attempt_id])
    end
    
    def review_required
      @review = @attempt.reviews.find_by_id(params[:id])
    end
    
    def reviewer_required
      redirect_to :root unless current_user.reviews.include? @review
    end
end
