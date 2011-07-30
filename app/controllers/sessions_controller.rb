class SessionsController < ApplicationController
  def browser_id
    res = JSON.parse(
      RestClient.post('https://browserid.org/verify', :assertion => params[:assertion], :audience => 'mozchallenge.dev')
    )
    
    if res['status'] == 'okay'
      unless user = User.find_by_email(res['email'])
        user = User.create!(:email => res['email'], :password => SecureRandom.urlsafe_base64) 
      end
    
      cookies.signed[:_mozchallenge_auth] = {
        :value => user.auth_token, 
        :httponly => true
      }
    
      render :json => {:next => new_user_profiles_url(user) }
    else
      # TODO: Pass an error message
      render :json => {:next => root_url}
    end
  end
  
  def destroy
    cookies.delete :_mozchallenge_auth
    reset_session
    redirect_to :root
  end
end
