require 'rails_helper'

RSpec.feature 'サインアップ', type: :system do
  include ActiveJob::TestHelper

  it 'ユーザーはサインアップに成功すること' do
    visit root_path
    click_link 'ユーザー登録'

    perform_enqueued_jobs do
      expect do
        fill_in 'user[nickname]', with: 'Example'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'test123'
        click_button 'ユーザー登録'
      end.to change(User, :count).by(1)

      expect(page).to have_content 'アカウント有効用のメールを送信しました。クリックして有効化をお願い致します。'
      expect(current_path).to eq root_path
    end

    # アカウント有効化メールのテストです
    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq ['test@example.com']
      expect(mail.from).to eq ['noreply@example.com']
      expect(mail.subject).to eq 'アカウントの有効化をお願いします。'
    end
  end
end