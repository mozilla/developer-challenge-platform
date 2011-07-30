class UsersController < ApplicationController
  def show
    @user = Profile.find_by_username(params[:id]).try(:user)
  end
end
