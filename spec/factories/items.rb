FactoryBot.define do
  factory :item do
    title { "MyString" }
    content { "MyText" }
    user { nil }
    price { 1 }
    saler_id { 1 }
    buyer_id { 1 }
    region { "MyString" }
  end
end
