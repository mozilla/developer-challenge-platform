class JudgingsController < ApplicationController
  before_filter :challenge_required
  before_filter :attempt_requried
  before_filter :judging_required
  before_filter :judge_required
  
  def update
    @judging.update_attributes(params[:judging])
    redirect_to @judging.user, :notice => 'Your judging has been saved'
  end
  
  private
    def challenge_required
      @challenge = Challenge.find_by_id(params[:challenge_id])
    end
    
    def attempt_requried
      @attempt = @challenge.attempts.find_by_id(params[:attempt_id])
    end
    
    def judging_required
      @judging = @attempt.judgings.find_by_id(params[:id])
    end
    
    def judge_required
      redirect_to :root unless current_user.judgings.include? @judging
    end
end
