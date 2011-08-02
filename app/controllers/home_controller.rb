class HomeController < ApplicationController
  def index
    @featured_challenge =  Challenge.featured.first
    @recent_challenges = Challenge.finished.limit(6).all - [@featured_challenge]
  end
end
