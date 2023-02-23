FactoryBot.define do
  factory :bid do
    association :user
    association :item
    amount { 5 }
  end
end
