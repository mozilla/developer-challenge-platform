class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?, :current_user
  before_filter :progress_challenges
  
  private
    def current_user
      @current_user ||= User.find_by_auth_token(cookies.signed[:_mozchallenge_auth]) if cookies.signed[:_mozchallenge_auth]
      cookies.delete :_mozchallenge_auth unless @current_user
      @current_user
    end
    
    alias :logged_in? :current_user
    
    def store_location(location=request.fullpath)
      session[:return_to] = location unless session[:return_to]
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def authorize_user
      unless logged_in?
        store_location
        redirect_to :new_session, :notice => 'You need to log in to do that'
      end
    end
    
    def progress_challenges
      # checks for challenges that need progressing to the next stage
      # this would normally be done in a background job but we're
      # fudging it for this prototype
      
      # progress challenges that have passed their end date to review stage
      #Challenge.active.where('ends_at < now()').each{|x| x.review!}
    end
end
