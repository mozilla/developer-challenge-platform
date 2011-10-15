class ChallengesController < ApplicationController
  before_filter :authorize_user, :only => [:new, :create]
  
  def new
    @challenge = Challenge.new
  end
  
  def create
    source = 'community'
    source = 'admin' if current_user.email =~ /@mozilla.com$/
    @challenge = Challenge.new(params[:challenge].merge(
      :user => current_user,
      :source => 'community'
    ))
    if @challenge.save
      redirect_to :root, :notice => 'Thank you for your submission'
    else
      logger.debug @challenge.errors.inspect.red
      render :new
    end
  end
  
  def show
    @challenge = Challenge.find_by_id!(params[:id])
  end
end
