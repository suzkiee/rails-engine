FactoryBot.define do
  factory :mock_item, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::Hipster.paragraph }
    unit_price {Faker::Number.within(range: 1..1000)}

    association :merchant, factory: :mock_merchant
  end
end
