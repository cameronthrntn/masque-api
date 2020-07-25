class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]

  def index
    unless params['thread_id']
      json_response({ message: 'A thread is required' }, :not_found)
    else
      @comments = Mask.where(thread_id: params['thread_id'])
      json_response(@comments)
    end
  end

  def create
    @comment = Comment.create!(comment_params)
    json_response(@comment, :created)
  end

  private

  def comment_params
    params.permit(:user_id, :thread_id, :content)
  end

  def set_mask
    @mask = Mask.find(params[:mask_id])
  end
end
