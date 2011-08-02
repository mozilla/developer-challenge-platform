class MessagesController < ApplicationController
  before_filter :message_required, :except => [:index, :new, :create]
  before_filter :check_ownership, :only => [:show]
  
  def index
    @received = current_user.received_messages
    @sent = current_user.sent_messages
  end
  
  def new
    @message = Message.new
    @message.recipient_username = params[:recipient] if params[:recipient]
  end
  
  def create
    @message = Message.new(params[:message].merge(:sender => current_user))
    @message.recipient = Profile.find_by_username(@message.recipient_username).try(:user)
    if @message.save
      redirect_to :messages
    else
      render :new
    end
  end
  
  def show
  end
  
  private
    def message_required
      @message = Message.find_by_id!(params[:id])
    end
    
    def check_ownership
      redirect_to :root unless @message.recipient  == current_user or @message.sender == current_user
    end
      
end
