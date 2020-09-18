class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def show
    @comments = Comment
      .select('Comments.*, Masks.topic_id, Masks.design, Masks.colour')
      .joins("LEFT JOIN masks ON comments.mask_id = masks.id")
      .where(masks: { topic_id: params[:id] })
    json_response(@comments)
  end

  def create
    @comment = Comment.create!(comment_params)
    json_response(@comment, :created)
  end

  private

  def comment_params
    params.permit(:user_id, :thread_id, :content, :reply_id)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end
