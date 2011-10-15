class VotesController < ApplicationController
  before_filter :authorize_user
  before_filter :challenge_required
  before_filter :attempt_requried
    
  def create
    @attempt.votes.create!(:user => current_user) if @attempt.votes.where(:user_id => current_user.id).empty?
    redirect_to [@challenge, @attempt], :notice => 'Thank you for your vote'
  end
  
  private
    def challenge_required
      @challenge = Challenge.find_by_id(params[:challenge_id])
    end
    
    def attempt_requried
      @attempt = @challenge.attempts.find_by_id(params[:attempt_id])
    end
end
