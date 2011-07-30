class Admin::BaseController < ApplicationController
  before_filter :admin_user_required
  
  private
    def admin_user_required
      redirect_to :root unless logged_in? and current_user.admin?
    end
end
