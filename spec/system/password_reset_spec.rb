require 'rails_helper'

RSpec.describe 'パスワードリセット機能', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_password_reset_path
  end

  describe 'パスワードリセット処理' do
    context '無効なメールアドレスを入力したとき' do
      it 'メール送信処理が実行されないこと' do
        fill_in 'password_reset[email]',	with: ''
        click_button '再設定メールを送信'
        expect(current_path).to eq password_resets_path
      end
    end
    context '有効なメールアドレスを入力したとき' do
      it 'メール送信処理が実行されないこと' do
        fill_in 'password_reset[email]',	with: user.email
        click_button '再設定メールを送信'
        expect(current_path).to eq root_path
      end
    end
  end
end
