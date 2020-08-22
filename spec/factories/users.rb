FactoryBot.define do
  factory :user do
    nickname  { "Alice" }
    sequence(:email) { |n| "exemple#{n}@example.com"}
    password { "password" }
    activated { true }
  end
end
