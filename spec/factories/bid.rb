FactoryBot.define do
  factory :bid do
    association :user
    amount { 5 }
  end
end
