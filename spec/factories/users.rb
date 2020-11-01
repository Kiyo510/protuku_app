FactoryBot.define do
  factory :user do
    nickname { 'Alice' }
    sequence(:email) { |n| "exemple#{n}@example.com" }
    password { 'password' }
    introduction { 'Nice to meet you' }
    activated { true }
  end
  factory :other_user, class: User do
    nickname { 'Bob' }
    sequence(:email) { |l| "test#{l}@example.com" }
    password { 'password' }
    introduction { 'Nice to meet you' }
    activated { true }
  end
  factory :twitter_client, class: User do
    nickname { 'Smith' }
    sequence(:email) { |m| "test#{m}@example.com" }
    password { 'password' }
    introduction { 'Nice to meet you' }
    activated { false }
  end
end
