require 'rails_helper'
include NotificationsHelper

RSpec.feature '投稿機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:item) { FactoryBot.create(:item, content: 'first post', user_id: user.id) }
  describe '投稿一覧表示機能' do
    before do
      visit login_path
      fill_in 'session[email]', with: login_user.email
      fill_in 'session[password]', with: login_user.password
      click_button 'ログイン'
      visit items_path
    end

    context '新規投稿したとき' do
      let(:login_user) { user }
      it '投稿に成功すること' do
        expect(Item.count).to eq 1
      end
    end

    context '投稿を削除したとき' do
      let(:login_user) { user }
      it '投稿の削除に成功すること' do
        visit item_path(item)
        page.accept_confirm do
          click_link '削除'
        end
        expect(page).to have_content '投稿を削除しました'
        expect(Item.count).to eq 0
      end
    end

    context 'userがログインしている時' do
      let(:login_user) { user }
      it 'userが作成した投稿が表示される' do
        expect(page).to have_content 'first post'
      end

      it '投稿詳細ページに編集、削除ボタンが表示される' do
        visit item_path(item)
        expect(page).to have_content '編集'
        expect(page).to have_content '削除'
      end

      it '投稿詳細ページに「話を聞いてみるボタン」が表示されない' do
        visit item_path(item)
        expect(page).not_to have_css '.message_btn'
      end
    end

    context 'other_userがログインしている時' do
      let(:login_user) { other_user }
      it 'userが作成した投稿が表示される' do
        expect(page).to have_content 'first post'
      end

      it '投稿詳細ページに編集、削除ボタンが表示されない' do
        visit item_path(item)
        expect(page).not_to have_content '編集'
        expect(page).not_to have_content '削除'
      end

      it '投稿詳細ページに「話を聞いてみるボタン」が表示さる' do
        visit item_path(item)
        expect(page).to have_css '.message_btn'
      end
    end
  end
end
