FactoryBot.define do
  factory :mock_merchant, class: Merchant do
    name { Faker::FunnyName.three_word_name }
  end
end

