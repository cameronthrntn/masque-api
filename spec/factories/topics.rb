FactoryBot.define do
  factory :topic do
    title { Faker::JapaneseMedia::OnePiece.quote }
    content { Faker::JapaneseMedia::OnePiece.quote }
    user_id nil
  end
end