FactoryBot.define do
  factory :message do
    association :user
    association :room
  end
end
