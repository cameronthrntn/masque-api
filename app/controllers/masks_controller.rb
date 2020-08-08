class MasksController < ApplicationController
  before_action :set_mask, only: [:show, :destroy]

  def index
    unless params['thread_id']
      json_response({ message: 'A thread is required' }, :not_found)
    else
      @mask = Mask.find_by!(thread_id: params['thread_id'])
      json_response(@mask)
    end
  end

  def create
    @mask = Mask.create!(mask_params)
    json_response(@mask, :created)
  end

  private

  def mask_params
    params.permit(:user_id, :thread_id, :design, :colour)
  end

  def set_mask
    @mask = Mask.find(params[:mask_id])
  end

end
