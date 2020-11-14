# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login', type: :system do
  let(:user) { FactoryBot.create(:user) }
  # ログインに成功すること
  it 'ログインに成功すること' do
    valid_login(user)
    expect(current_path).to eq user_path(user)
    expect(page).to have_content 'ログインに成功しました。'
    expect(page).to have_content '自己紹介'
    expect(page).to have_content '仲間を募る'
  end

  it '無効な情報ではログインに失敗すること' do
    visit root_path
    click_link 'ログイン'
    fill_in 'session[email]', with: ' '
    fill_in 'session[password]', with: ' '
    click_button 'ログイン'

    expect(current_path).to eq login_path
    expect(page).to have_content 'ログイン'
    expect(page).to have_content 'パスワードまたはEメールアドレスが間違っています。'
  end

  it 'アカウントを有効化していないユーザーはログインに失敗する' do
    invalid_user = FactoryBot.create(:user, activated: false)
    valid_login invalid_user
    expect(current_path).to eq root_path
    expect(page).to have_content 'アカウントが有効化されていません。 '
    expect(page).to have_content 'Eメールのアカウント有効化リンクをクリックしてください。'
  end
end
