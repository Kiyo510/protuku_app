require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  # ユーザーはサインアップに成功する
  scenario "user successfully signs up" do
    visit root_path
    click_link "ユーザー登録"

    perform_enqueued_jobs do
      expect {
        fill_in "名前",              with: "Example"
        fill_in "メールアドレス",     with: "test@example.com"
        fill_in "パスワード",         with: "test123"
        click_button "ユーザー登録"
      }.to change(User, :count).by(1)

      expect(page).to have_content "アカウント有効化メールを送信しました。"
      expect(current_path).to eq root_path
    end

    # 以下はアカウント有効化メールのテストです
    # 詳細なテストは後で追加します
    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq ["test@example.com"]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.subject).to eq "Account activation"
    end
  end
end