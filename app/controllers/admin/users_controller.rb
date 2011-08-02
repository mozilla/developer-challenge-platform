class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all # TODO: Pagination
  end
  
  def show
    @user = Profile.find_by_username!(params[:id]).try(:user)
  end
  
  def update
    @user = Profile.find_by_username!(params[:id]).try(:user)
    @user.update_attributes(params[:user], :as => :admin)
    redirect_to [:admin, @user]
  end
end
