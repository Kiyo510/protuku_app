#管理ユーザー（メイン）を作成
User.create!(nickname: "Kiyosuke",
             email: "kiyosuke@yahoo.co.jp",
             password: "password",
             activated: true,
             admin: true)

User.create!(nickname: "Kiyo2",
             email: "kiyo2@yahoo.co.jp",
             password: "password",
             activated: true,
             admin: true)

User.create!(nickname: "Kiyo3",
             email: "kiyo3@yahoo.co.jp",
             password: "password",
             activated: true,
             admin: true)
