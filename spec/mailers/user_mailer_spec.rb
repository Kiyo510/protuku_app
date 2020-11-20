# frozen_string_literal: true

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user, email: 'mailer_tester@example.com') }
  # Base64でエンコードされたものをデコードして比較できるようにする
  let(:mail_body) { mail.body.encoded.split(/\r\n/).map { |i| Base64.decode64(i) }.join }

  describe 'パスワードリセット処理' do
    let(:mail) { UserMailer.password_reset(user) }

    it 'ヘッダーが正しく表示されること' do
      user.reset_token = User.new_token
      expect(mail.to).to eq ['mailer_tester@example.com']
      expect(mail.from).to eq ['miraishida00510@gmail.com']
      expect(mail.subject).to eq 'パスワードの再設定'
    end

    # メールプレビューのテスト
    it 'メール文が正しく表示されること' do
      user.reset_token = User.new_token
      expect(mail_body).to match user.reset_token
      expect(mail_body).to match CGI.escape(user.email)
    end
  end

  describe 'アカウント有効化メール送信処理' do
    let(:mail) { UserMailer.account_activation(user) }
    # Base64 encodeをデコードして比較できるようにする

    it 'ヘッダーが正しく表示されること' do
      user.activation_token = User.new_token
      expect(mail.to).to eq ['mailer_tester@example.com']
      expect(mail.from).to eq ['miraishida00510@gmail.com']
      expect(mail.subject).to eq 'アカウントの有効化をお願いします。'
    end

    # メールプレビューのテスト
    it 'メール文が正しく表示されること' do
      user.activation_token = User.new_token
      expect(mail_body).to match user.activation_token
      expect(mail_body).to match CGI.escape(user.email)
    end
  end
end
