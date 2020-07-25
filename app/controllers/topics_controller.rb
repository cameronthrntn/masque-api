class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :deestroy]

  def index
    @topics = Topic.all
    json_response(@topics)
  end

  def create
    @topic = Topic.create!(topic_params)
    json_response(@topic, :created)
  end

  def destroy
    @topic.destroy
    head :no_content
  end

  private

  def topic_params
    params.permit(:title, :content, :user_id)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
