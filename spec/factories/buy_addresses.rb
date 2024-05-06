FactoryBot.define do
  factory :buy_address do
    post_number {Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4)}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    locality {Faker::Address.city}
    house_number {Faker::Address.street_address}
    building_name {Faker::Company.name}
    phone_number {Faker::Number.leading_zero_number(digits: 11)} 
    token {Faker::Alphanumeric.alphanumeric(number: 30)}
  end
end
