class ProfilesController < ApplicationController
  def new
    if current_user.profile
      redirect_to :root
    else
      @profile = Profile.new
    end
  end
  
  def create
    @profile = Profile.new(params[:profile].merge(:user => current_user))
    if @profile.save
      redirect_to :root
    else
      render :new
    end
  end
end
