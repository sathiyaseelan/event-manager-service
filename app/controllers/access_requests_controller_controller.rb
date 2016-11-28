class AccessRequestsController < ApplicationController

  def pending
    render json: {success: true, requests: AccessRequest.pending}
  end

  def rejected
    render json: {success: true, requests: AccessRequest.rejected }
  end

  def approved
    render json: {success: true, requests: AccessRequest.approved }
  end

  def admin_requests
    render json: {success: true, requests: AccessRequest.pending.admin_only}
  end

  def super_user_requests
    render json: {success: true, requests: AccessRequest.pending.super_user_only}
  end

  def new
    if params[:new_role]
      @access_request = AccessRequest.new(new_role: params[:new_role], created_by: current_user)
      if @access_request.save
        render json: {success: true}, status: 200
      else
        render json: {success: false, reason: @access_request.errors.full_messages}, status: 500
      end
    else
      render json: {success: false, message: 'new role parameter missing'}, status: 400
    end
  end


  def update
    @access_request = AccessRequest.find(params[:id])
    if @access_request
      if params[:type] == 'approve'
        @access_request.status = "A"
        @access_request.approved_by = current_user
      elsif params[:type] == 'reject'
        @access_request.status = "D"
        @access_request.rejected_by = current_user
      else
        render json: {success: false, message: 'Missing approve/ reject parameter'}, status: 400
      end
      if @access_request.valid? && @access_request.save
        render json: {success: true}, status: 200
      else
        render json: {success: false, reason: @access_request.errors.full_messages}, status: 500
      end

    else
      render json: {success: false, message: 'Invalid request id'}, status: 400
    end
  end

end
