class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.signed[:_mozchallenge_auth] = {
        :value => @user.auth_token, 
        :httponly => true
      }
      redirect_to new_user_profiles_url(@user)
    else
      render :new
    end
  end
  
  def show
    @user = Profile.find_by_username!(params[:id]).try(:user)
  end
end
