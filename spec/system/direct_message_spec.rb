# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Homes', type: :system do
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item, user_id: other_user.id) }

  before do
    valid_login user
    visit item_path(item)
    find('.message_btn').click
  end

  describe 'DMルーム' do
    context 'userがメッセージを送信したとき' do
      it 'othe_userへのメッセージの送信が成功すること', js: true do
        expect(page).to have_content "#{other_user.nickname}さんへメッセージを送る"
        expect do
          fill_in 'message[content]',	with: 'こんにちは'
          click_on '送信'
        end.to change(Message, :count).by(1)
           .and change(Notification, :count).by(1)

        expect(page).to have_content 'メッセージを送信しました'
        expect(page).to have_content 'こんにちは'
        expect(page).to have_content user.nickname.to_s

        # other_userでログインし直して、userからのメッセージの通知が来ているか確認する
        log_out

        valid_login other_user
        visit items_path
        find('.fa-bell').click
        expect(page).to have_content "#{user.nickname} さんから メッセージ が来ています"
      end
    end

    context 'userが空文字を送信したとき' do
      it 'userはメッセージの送信に失敗すること' do
        expect(page).to have_content "#{other_user.nickname}さんへメッセージを送る"
        expect do
          fill_in 'message[content]',	with: '　'
          click_on '送信'
        end.to change(Message, :count).by(0)
           .and change(Notification, :count).by(0)

        expect(page).to have_content 'メッセージの送信に失敗しました'
      end
    end

    context 'userが2000文字以上入力したとき' do
      it 'userはメッセージの送信に失敗すること' do
        expect(page).to have_content "#{other_user.nickname}さんへメッセージを送る"
        expect do
          fill_in 'message[content]',	with: 'a' * 2001
          click_on '送信'
        end.to change(Message, :count).by(0)
           .and change(Notification, :count).by(0)

        expect(page).to have_content 'メッセージの送信に失敗しました'
      end
    end
  end
end
