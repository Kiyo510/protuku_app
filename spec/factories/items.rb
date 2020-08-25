FactoryBot.define do
  factory :item do
    title { 'testtitle' }
    content { 'testcontent' }
    user_id { '1' }
    region { '東京' }
    association :user
  end
end
