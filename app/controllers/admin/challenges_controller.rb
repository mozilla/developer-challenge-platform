class Admin::ChallengesController < Admin::BaseController
  def index
    @challenges = Challenge.all # TODO: Pagination
  end
  
  def new
    @challenge = Challenge.new(
      :starts_at => Time.now.utc.beginning_of_day, 
      :ends_at => (Time.now.utc + 5.days).beginning_of_day
    )
  end
  
  def activate
    @challenge = Challenge.find_by_id!(params[:id])
    @challenge.activate!
    redirect_to :admin_challenges
  end
  
  def create
    @challenge = Challenge.new(params[:challenge].merge(
      :user => current_user,
      :source => 'admin'
    ))
    if @challenge.save
      redirect_to :admin_challenges
    else
      render :new
    end
  end
end
