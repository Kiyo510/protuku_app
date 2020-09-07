FactoryBot.define do
  factory :user do
    nickname { 'Alice' }
    sequence(:email) { |n| "exemple#{n}@example.com" }
    password { 'password' }
    activated { true }
  end
  factory :other_user, class: User do
    nickname { 'Bob' }
    sequence(:email) { |m| "exemple#{m}@example.com" }
    password { 'password' }
    activated { true }
  end
end
