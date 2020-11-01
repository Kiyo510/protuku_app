require 'rails_helper'
include NotificationsHelper

RSpec.feature 'Homes', type: :system do
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item, user_id: other_user.id) }

  describe "DMルーム" do
    context "userがメッセージを送信したとき" do
      it "othe_userへのメッセージの送信が成功すること" do
        valid_login user
        visit item_path(item)
        find('.message_btn').click
        expect(page).to have_content "#{other_user.nickname}さんへメッセージを送る"
        expect {
          fill_in "message[content]",	with: "TestMessage"
          click_on '送信'
        }.to change(Message, :count).by(1).and change(Notification, :count).by(1)

        expect(page).to have_content 'TestMessage'
        expect(page).to have_content "#{user.nickname}"

        log_out

        #other_userにuserからのメッセージの通知が来ているか
        valid_login other_user
        visit items_path
        find('.fa-bell').click
        expect(page).to have_content "#{user.nickname} さんから メッセージ が来ています"
      end
    end
  end
end
