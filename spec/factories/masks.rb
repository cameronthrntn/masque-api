require 'yaml'

masks = YAML.load(File.read("config/masks.yml"))
colours = YAML.load(File.read("config/colours.yml"))

FactoryBot.define do
  factory :mask do
    mask { masks.sample }
    colour { colours.sample }
    topic_id nil
    user_id nil
  end
end