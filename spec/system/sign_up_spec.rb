require 'rails_helper'
include NotificationsHelper

RSpec.feature 'サインアップ', type: :system do
  background do
    ActionMailer::Base.deliveries.clear
  end

  it 'ユーザーはサインアップに成功すること' do
    visit root_path
    click_link 'ユーザー登録'

    perform_enqueued_jobs do
      expect do
        fill_in 'user[nickname]', with: 'Example'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'test123'
        check 'user[accepted]'
        click_button 'ユーザー登録'
      end.to change(User, :count).by(1)

      expect(page).to have_content 'アカウント有効用のメールを送信しました。クリックして有効化をお願い致します。'
      expect(current_path).to eq root_path
    end
  end
end
