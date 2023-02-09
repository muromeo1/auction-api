FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name: name) }
    password { Faker::Internet.password }
    password_confirmation { password }

    factory :user_with_bid do
      after :create do |user|
        create(:bid, user: user)
      end
    end
  end
end
