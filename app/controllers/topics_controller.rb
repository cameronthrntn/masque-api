class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :destroy]

  def index
    distance = params[:distance]
    latitude = params[:latitude].to_i
    longitude = params[:longitude].to_i
    if distance === 'closest'
      @topics = Topic.where('topics.longitude >= ?', longitude.to_i - 1).where('topics.longitude <= ?', longitude + 1).where('topics.latitude >= ?', latitude - 1).where('topics.latitude <= ?', latitude + 1)
    elsif distance === 'midrange'
      @topics = Topic.where('topics.longitude >= ?', longitude.to_i - 2).where('topics.longitude <= ?', longitude + 2).where('topics.latitude >= ?', latitude - 2).where('topics.latitude <= ?', latitude + 2)
    else
      @topics = Topic.all
    end
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
    params.permit(:title, :content, :user_id, :latitude, :longitude)
  end

  def set_topic
    puts params[:id]
    @topic = Topic.select('Topics.id, Topics.title, Topics.content, Topics.created_at, Masks.design, Masks.colour').joins("LEFT JOIN masks ON topics.id = masks.topic_id AND topics.user_id = masks.user_id").where(masks: {topic_id: params[:id]}).first
  end
end
