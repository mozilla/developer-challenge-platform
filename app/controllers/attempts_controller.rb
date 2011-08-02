class AttemptsController < ApplicationController
  before_filter :authorize_user
  before_filter :challenge_requried
  before_filter :attempt_required, :except => [:new, :create]
  
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
  
  def edit
  end
  
  def update
    @attempt.update_attributes(params[:attempt])
    redirect_to @attempt.user
  end
  
  private
    def challenge_requried
      @challenge = Challenge.find_by_id!(params[:challenge_id])
    end
    
    def attempt_required
      @attempt = Attempt.find_by_id!(params[:id])
    end
end
