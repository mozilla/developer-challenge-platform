class Admin::CommunityController < Admin::BaseController
  def show
    @challenges = Challenge.community
  end
end
