require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  # ログインに成功すること
  scenario 'user successfully login' do
    valid_login(user)

    expect(current_path).to eq user_path(user)
    expect(page).to have_content 'ログアウト'
    expect(page).to have_content 'ログインに成功しました。'
  end

  # 無効な情報ではログインに失敗すること
  scenario "user doesn't login with invalid information" do
    visit root_path
    click_link 'ログイン'
    fill_in 'session[email]', with: ' '
    fill_in 'session[password]', with: ' '
    click_button 'ログイン'

    expect(current_path).to eq login_path
    expect(page).to have_content 'ログイン'
    expect(page).to have_content 'パスワードまたはEメールアドレスが間違っています。'
  end
  # アカウントを有効化していないユーザーはログインに失敗する
  scenario "user doesn't login with activated false" do
    invalid_user = FactoryBot.create(:user, activated: false)
    valid_login invalid_user
    expect(current_path).to eq root_path
    expect(page).to have_content 'アカウントが有効化されていません。 '
    expect(page).to have_content 'Eメールのアカウント有効化リンクをクリックしてください。'
  end
end
