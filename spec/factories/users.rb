FactoryBot.define do
  factory :user do
    access { "#{Faker::Lorem.word}#{rand(9999)}#{rand(999999999)}" }
  end
end