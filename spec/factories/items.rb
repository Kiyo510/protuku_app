FactoryBot.define do
  factory :item do
    title { 'testtitle' }
    content { 'testcontent' }
    region { '東京' }
    association :user
  end
end
