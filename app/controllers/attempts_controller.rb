class AttemptsController < ApplicationController
  before_filter :authorize_user
  before_filter :challenge_requried
  
  def new
    @attempt = Attempt.new
  end
  
  def create
    @attempt = Attempt.new(params[:attempt].merge(:challenge => @challenge, :user => current_user))
    if @attempt.save
      redirect_to @challenge
    else
      render :new
    end
  end
  
  private
    def challenge_requried
      @challenge = Challenge.find_by_id!(params[:challenge_id])
    end
end
