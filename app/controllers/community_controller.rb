class CommunityController < ApplicationController
  def show
    @challenges = Challenge.community.limit(20)
  end
end
