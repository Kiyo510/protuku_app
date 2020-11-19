# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    title { 'testtitle' }
    content { 'testcontent' }
    association :prefecture
    association :user
  end
end
