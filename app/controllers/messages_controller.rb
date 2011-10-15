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
    challenge = Challenge.find_by_id(params[:challenge_id]) if params[:challenge_id]
    if challenge
      @message.challenge = challenge 
      @message.subject = challenge.title
    end
  end
  
  def create
    recipients = params[:message][:recipient_username].split(',')
    recipients.each do |r|
      recipient = Profile.find_by_username(r).try(:user)
      Message.create!(params[:message].merge(:sender => current_user, :recipient => recipient)) if recipient and (recipient != current_user)
    end
    redirect_to :messages, :notice => 'Message sent'
  end
  
  def show
  end
  
  private
    def message_required
      @message = Message.find_by_id!(params[:id])
    end
    
    def check_ownership
      redirect_to :root unless @message.recipient == current_user or @message.sender == current_user
    end
      
end
