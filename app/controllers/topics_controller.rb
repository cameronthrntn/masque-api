class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :destroy]

  def index
    @topics = Topic.all
    json_response(@topics)
  end

  def show
    json_response(set_topic)
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
    @topic = Topic.select('Topics.id, Topics.title, Topics.content, Topics.created_at, Masks.design, Masks.colour').joins("LEFT JOIN masks ON topics.id = masks.topic_id AND topics.user_id = masks.user_id").where(masks: {topic_id: params[:id]}).first
  end
end
