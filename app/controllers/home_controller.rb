class HomeController < ApplicationController
  def index
    @active_challenges = Challenge.active
    @open_challenges = Challenge.open
    @past_challenges = Challenge.finished.limit(6).all
  end
end
