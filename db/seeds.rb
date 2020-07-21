#管理ユーザー（メイン）を作成
User.create!(nickname: "Kiyosuke",
             email: "kiyosuke@yahoo.co.jp",
             password: "password",
             activated: true,
             admin: true)
