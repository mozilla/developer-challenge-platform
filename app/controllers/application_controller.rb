class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?, :current_user
  
  private
    def current_user
      @current_user ||= User.find_by_auth_token(cookies.signed[:_mozchallenge_auth]) if cookies.signed[:_mozchallenge_auth]
      cookies.delete :_mozchallenge_auth unless @current_user
      @current_user
    end
    
    alias :logged_in? :current_user
    
    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
