require 'yaml'

class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :destroy]
  wrap_parameters false

  def index
    distance = params[:distance]
    latitude = params[:latitude].to_i
    longitude = params[:longitude].to_i
    amount = params[:amount].to_i
    page = params[:page].to_i - 1
    if distance === 'closest'
      @topics = Topic
        .where('topics.longitude >= ?', longitude.to_i - 1)
        .where('topics.longitude <= ?', longitude + 1)
        .where('topics.latitude >= ?', latitude - 1)
        .where('topics.latitude <= ?', latitude + 1)
        .limit(amount)
        .offset(amount * page)
    elsif distance === 'midrange'
      @topics = Topic
        .where('topics.longitude >= ?', longitude.to_i - 2)
        .where('topics.longitude <= ?', longitude + 2)
        .where('topics.latitude >= ?', latitude - 2)
        .where('topics.latitude <= ?', latitude + 2)
        .limit(amount)
        .offset(amount * page)
    else
      @topics = Topic.all.limit(amount).offset((amount * page) + 1)
    end
    json_response(@topics)
  end

  def show
    json_response(set_topic)
  end

  def create
    @topic = Topic.create!(topic_params)
    masks = YAML.load(File.read("config/masks.yml"))
    colours = YAML.load(File.read("config/colours.yml"))
    Mask.create!({user_id: params[:user_id], topic_id: @topic[:id], design: masks.sample, colour: colours.sample})
    json_response(@topic, :created)
  end

  def destroy
    @topic.destroy
    head :no_content
  end

  private

  def topic_params
    puts params
    params.permit(:title, :content, :user_id, :latitude, :longitude, :distance, :amount, :page)
  end

  def set_topic
    @topic = Topic.select('Topics.id, Topics.title, Topics.content, Topics.created_at, Masks.design, Masks.colour').joins("LEFT JOIN masks ON topics.id = masks.topic_id AND topics.user_id = masks.user_id").where(masks: {topic_id: params[:id]}).first
  end
end
