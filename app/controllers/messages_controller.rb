class MessagesController < ApplicationController
  before_action :set_group
  before_action :correct_user
  
  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end
  
  def create
    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください'
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def correct_user
    redirect_to root_path unless current_user.in? (@group.users)
  end
end