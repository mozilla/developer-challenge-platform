class HomeController < ApplicationController
  def index
    @featured_challenge =  Challenge.active.first
    @recent_challenges = Challenge.finished.limit(5).all - [@featured_challenge]
  end
end
