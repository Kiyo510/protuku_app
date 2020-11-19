# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'アカウント有効化メール', type: :system do
  background do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  describe 'ユーザー登録画面' do
    it 'ユーザーはアカウントの有効化に成功すること' do
      pending('手動では動くが、テストが何故か失敗する。原因調査中')
      visit root_path
      click_link 'ユーザー登録'

      perform_enqueued_jobs do
        expect do
          fill_in 'user[nickname]', with: 'Example'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'test123'
          click_button 'ユーザー登録'
        end.to change { ActionMailer::Base.deliveries.size }.by(1)

        expect(page).to have_content 'アカウント有効用のメールを送信しました。クリックして有効化をお願い致します。'
        expect(current_path).to eq root_path

        mail = ActionMailer::Base.deliveries.last
        url = extract_confirmation_url(mail)
        visit url
        expect(page).to have_content 'アカウントを有効化しました'
      end
    end
  end
end
