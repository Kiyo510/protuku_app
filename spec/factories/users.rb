FactoryBot.define do
  factory :user do
    nickname  { "Alice" }
    sequence(:email) { |n| "exemple#{n}@example.com"}
    password { "password" }
    password_confirmation { "password" }
    activated { true }
  end
end
