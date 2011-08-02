class Admin::ChallengesController < Admin::BaseController
  before_filter :challenge_requried, :except => [:index, :new, :create]
  
  def index
    @challenges = Challenge.admin # TODO: Pagination
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
  
  def feature
    @challenge.feature!
    redirect_to :admin_challenges
  end
  
  def review
    @challenge.review!
    redirect_to [:admin, @challenge]
  end
  
  def assign_reviewers
    reviewers = User.reviewers.find(params[:user_id])
    reviewers.each do |reviewer|
      @challenge.assign_reviewer(current_user, reviewer) unless @challenge.reviewers.include? reviewer
    end
    redirect_to [:admin, @challenge]
  end
  
  def assign_judges
    judges = User.judges.find(params[:user_id])
    judges.each do |judge|
      @challenge.assign_judge(current_user, judge) unless @challenge.judges.include? judge
    end
    redirect_to [:admin, @challenge]
  end
  
  def judge
    shortlisted_attempts = @challenge.attempts.find(params[:attempt_id])
    shortlisted_attempts.each{|x| x.update_attribute :shortlisted, true}
    @challenge.judge!
    redirect_to [:admin, @challenge]
  end
  
  def complete
    @challenge.finish!
    redirect_to [:admin, @challenge]
  end
  
  private
    def challenge_requried
      @challenge = Challenge.find_by_id!(params[:id])
    end
  
end
