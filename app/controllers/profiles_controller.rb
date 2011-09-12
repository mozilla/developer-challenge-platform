class ProfilesController < ApplicationController
  def new
    if current_user.profile
      redirect_back_or_default :root
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
  
  def github
    redirect_to :root unless logged_in? and current_user.profile
    profile = current_user.profile
    
    auth = request.env['omniauth.auth']
    
    profile.update_attributes(
      :github_token => auth['credentials']['token'],
      :github_username => auth['user_info']['nickname'],
      :github_url => auth['user_info']['urls']['GitHub'],
      :github_public_repo_count => auth['extra']['user_hash']['public_repo_count'],
      :github_followers_count => auth['extra']['user_hash']['followers_count']
    )
    
    redirect_to current_user
  end
  
  def twitter
    redirect_to :root unless logged_in? and current_user.profile
    profile = current_user.profile
    
    auth = request.env['omniauth.auth']
    
    profile.update_attributes(
      :twitter_token => auth['credentials']['token'],
      :twitter_secret => auth['credentials']['secret'],
      :twitter_username => auth['user_info']['nickname']
    )
    
    redirect_to current_user
  end
end
