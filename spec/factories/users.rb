# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { 'Alice' }
    sequence(:email) { |n| "exemple#{n}@example.com" }
    password { 'password' }
    introduction { 'Nice to meet you' }
    accepted { true }
    activated { true }
  end
  factory :other_user, class: User do
    nickname { 'Bob' }
    sequence(:email) { |l| "test#{l}@example.com" }
    password { 'password' }
    introduction { 'Nice to meet you' }
    accepted { true }
    activated { true }
  end
end
