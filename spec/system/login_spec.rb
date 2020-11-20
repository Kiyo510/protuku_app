# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login', type: :system do
  let(:user) { FactoryBot.create(:user) }

  context '有効な情報を入力したとき' do
    it 'ユーザーはログインに成功すること' do
      valid_login(user)
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'ログインに成功しました。'
      expect(page).to have_content '自己紹介'
      expect(page).to have_content '仲間を募る'
    end
  end

  context '無効な情報を入力したとき' do
    it 'ユーザーはログインに失敗すること' do
      visit root_path
      click_on 'ログイン', match: :first
      fill_in 'session[email]', with: ' '
      fill_in 'session[password]', with: ' '
      page.all('.uk-button-primary')[1].click

      expect(current_path).to eq login_path
      expect(page).to have_content 'ログイン'
      expect(page).to have_content 'パスワードまたはEメールアドレスが間違っています。'
    end
  end

  context 'アカウントを有効化していないユーザーのとき' do
    it 'ユーザーはログインに失敗する' do
      invalid_user = FactoryBot.create(:user, activated: false)
      valid_login invalid_user
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウントが有効化されていません。'
      expect(page).to have_content 'Eメールのアカウント有効化リンクをクリックしてください。'
    end
  end
end
