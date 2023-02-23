FactoryBot.define do
  factory :item do
    name { Faker::Space.galaxy }
    instant_buy_price { 10 }
  end
end
