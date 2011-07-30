class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all # TODO: Pagination
  end
end
