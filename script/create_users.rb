# frozen_string_literal: true

users = [
  'うーじー', 'moko', 'gappai', '渡辺', 'カノン', 'みつ',
  '親分', 'SHIN', 'マサ', 'あずき', 'れすと', 'リンドウ',
  'ケンぼー', 'mayu-n', 'ノンコ', 'YUKI', 'なむる', 'mon',
  'ノエル', ' たーぼう', 'ゆうり', 'C.Janmen', '痛風予備軍',
  'にせものかいはつ', 'ぱぱじーじ', 'なつ', 'アポリー', 'GTO',
  'Hopstep', '秋', 'エミリーママ', 'LEMONed', '安藤', 'しゅうや',
  'Koro', 'どにち_たいやき', 'Light'
]

emails = [
  'u-ji', 'moko', 'gappai', 'watanabe', 'karen', 'mitu', 'oyabun',
  'shin', 'masa', 'azuki', 'resuto', 'rindou', 'kenbo', 'mayu-n', 'nonko', 'yuki',
  'namuru', 'mon', 'noeru', 'ta-bou', 'yuuri', 'c-janmen', 'tuhuyobigun',
  'nisemonokaihatu', 'papaji-ji', 'aki', 'apori', 'gto', 'hopstep', 'natsu',
  'emiri-mama', 'remoned', 'andou', 'syuuya', 'koro', 'doniti_taiyaki', 'light'
]

users.zip(emails) do |user, email|
  User.create(
    nickname: user,
    password: ENV['SEED_DATA_PASSWORD'],
    email: "#{email}@protuku.com",
    activated: true,
    accepted: true
  )
end
