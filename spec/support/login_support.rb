# frozen_string_literal: true

# 新しいモジュールを作成
module LoginSupport
  def valid_login(user)
    visit root_path
    click_link 'ログイン', match: :first
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    page.all('.uk-button-primary')[1].click
  end

  def log_out
    find('.fa-caret-down').click
    click_link 'ログアウト'
  end
end
