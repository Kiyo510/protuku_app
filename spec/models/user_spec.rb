require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  describe User do
    # factory_botが有効化どうか検査
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end

  # Shoulda Matchers
  it { is_expected.to validate_presence_of :nickname }
  it { is_expected.to validate_length_of(:nickname).is_at_most(30) }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email adress' do
    FactoryBot.create(:user, email: 'alice@example.com')
    user = FactoryBot.build(:user, email: 'Alice@example.com')
    user.valid?
    # expect(user.errors[:email]).to include("そのEmailアドレスは既に登録されています。")
  end

  # メールアドレスの有効性
  describe 'email validation should reject incalid addresses' do
    # 無効なメールアドレスの場合
    it 'should be invalid' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |_invalid_address|
        user.email = invalid_addresses
        expect(user).to_not be_valid
      end
    end
  end

  describe 'before_save' do
    describe '#email_downcase' do
      # let!を使うことでbefore doのように先に実行される
      let!(:user) { create(:user, email: 'ORIGINAL@EXAMPLE.COM') }
      it 'makes email to low case' do
        expect(user.reload.email).to eq 'original@example.com'
      end
    end
  end

  describe "user_avatar" do
    it "should indicate user_avatar" do
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')), filename: 'test.jpg', content_type: 'image/jpg')
      expect(user).to be_valid
    end

    it "should not be over than 5MB" do
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test_5mb.jpg')), filename: 'test_5mb.jpg', content_type: 'image/jpg')
      expect(user).to  be_invalid
    end

    it "should be only images file" do
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test.pdf')), filename: 'test.pdf', content_type: 'application/pdf')
      expect(user).to be_invalid
    end
  end

  #ユーザーの退会処理のテスト
  describe "user_delete" do
    let!(:item) { FactoryBot.create(:item, user_id: user.id)}
    it "user successfully delete" do
      expect{ user.destroy }.to change{ User.count }.by(-1)
    end

    it 'userを削除すると、userの投稿も削除されること' do
      expect{ user.destroy }.to change{ Item.count }.by(-1)
    end
  end
end

#  describe "when password doesn't match confirmation" do
#   #一致する場合
#   it "is valid when password confirmation matches password" do
#     user = FactoryBot.build(:user, password: "password", password_confirmation: "password")
#     expect(user).to be_valid
#   end

#   #一致しない場合
#   it "is not valid when password confirmation is not matches password" do
#     user = FactoryBot.build(:user, password: "password", password_confirmation: "passward")
#     user.valid?
#       expect(user.errors[:password_confirmation]).to include("パスワードの確認が一致していません。")
#   end
