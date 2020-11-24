# frozen_string_literal: true

User.create!(nickname: 'Kiyosuke',
             email: 'kiyosuke@yahoo.co.jp',
             password: 'password',
             activated: true,
             accepted: :true,
             admin: true)

User.create!(nickname: 'Kiyo2',
             email: 'kiyo2@yahoo.co.jp',
             password: 'password',
             activated: true,
             accepted: :true,
             admin: true)

User.create!(nickname: 'Kiyo3',
             email: 'kiyo3@yahoo.co.jp',
             password: 'password',
             activated: true,
             accepted: :true,
             admin: true)

5.times do
  User.create!(
    nickname: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

150.times do |index|
  Item.create!(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    content: "本文#{index}",
    prefecture_id: 1
  )
end

21.times do |i|
  user = User.find(2)
  item = Item.find(i + 1)
  Stock.create!(
    user: user,
    item: item
  )
end
