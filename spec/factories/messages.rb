FactoryBot.define do
  factory :message do
    content { "MyText" }
    room { nil }
    send_user { nil }
  end
end
