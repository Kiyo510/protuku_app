FactoryBot.define do
  factory :tagmap do
    association :item
    association :tag
  end
end
