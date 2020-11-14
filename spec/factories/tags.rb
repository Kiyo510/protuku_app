# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:tag_name) { |n| "test_tag#{n}" }
  end
end
