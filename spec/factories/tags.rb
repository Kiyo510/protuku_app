FactoryBot.define do
  factory :tag do
    tag_name { "ruby Rails" }
    association :item
  end
end
