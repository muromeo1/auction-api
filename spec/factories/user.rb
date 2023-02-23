FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name: name) }
    password { Faker::Internet.password }
    password_confirmation { password }

    factory :user_with_bid do
      transient do
        item { create(:item) }
      end

      after :create do |user, options|
        create(:bid, user: user, item: options.item)
      end
    end
  end
end
