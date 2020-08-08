FactoryBot.define do
  factory :comment do
    content { Faker::JapaneseMedia::OnePiece.quote }
    reply_id nil
    topic_id nil
    user_id nil
  end
end