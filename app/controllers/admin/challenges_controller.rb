class Admin::ChallengesController < Admin::BaseController
  before_filter :challenge_requried, :except => [:index, :new, :create]
  
  def index
    @challenges = Challenge.all # TODO: Pagination
  end
  
  def new
    @challenge = Challenge.new
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
  
  def show
  end
  
  def edit
  end
  
  def update
    @challenge.update_attributes(params[:challenge])
    redirect_to :admin_challenges
  end
  
  def activate
    @challenge.activate!
    redirect_to :admin_challenges
  end
  
  private
    def challenge_requried
      @challenge = Challenge.find_by_id!(params[:id])
    end
  
end
