FactoryBot.define do
  factory :mock_transaction, class: Transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { "08/13" }
    result { ["success", "failed"].sample }

    association :invoice, factory: :mock_invoice
  end
end
