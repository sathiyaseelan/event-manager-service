class MessagesController < ApplicationController

  def inbox
    @messages = current_user.inbox_messages
    render json: {success: true, messages: @messages}, status: 200
  end

  def outbox
    @messages = current_user.outbox_messages
    render json: {success: true, messages: @messages}, status: 200
  end

  def compose
    @message = Message.new(title: params[:title], content: params[:content], created_by: current_user)
    to_user = User.find(email: params[:to])
    if to_user
      @message.to = to_user
      if @message.valid? && @message.save
        render json: {success: true}, status: 200
      else
        render json: {success: false, reason: "Internal server error"}, status: 500
      end
    else
      render json: {success: false, reason: "Invalid to mail address"}, status: 400
    end
  end

  # For autocomplete
  def emails
    if params[:prefix] && !params[:prefix].empty?
      render json: {success: true, emails: SearchSuggestion.emails_for(params[:prefix])}, status: 200
    else
      render json: {success: false, reason: "Parameter prefix is missing"}
    end
  end

end
