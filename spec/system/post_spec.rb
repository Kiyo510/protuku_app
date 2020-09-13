require 'rails_helper'

RSpec.feature '投稿機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  describe "投稿一覧表示機能" do
    before do
      FactoryBot.create(:item, content: 'first post', user_id: user.id)
      visit login_path
      fill_in 'session[email]', with: login_user.email
      fill_in 'session[password]', with: login_user.password
      click_button 'ログイン'
      visit items_path
    end

    context "userがログインしている時" do
      let(:login_user) { user }
      it 'userが作成した投稿が表示される' do
        expect(page).to have_content 'first post'
      end

      it '投稿詳細ページに編集、削除ボタンが表示される' do
        visit item_path(user)
        expect(page).to have_content '編集'
        expect(page).to have_content '削除'
      end

      it "投稿詳細ページにメッセージを送るボタンが表示されない" do
        visit item_path(user)
        expect(page).not_to have_css '.message_btn'
      end
    end

    context "other_userがログインしている時" do
      let(:login_user) { other_user }
      it 'userが作成した投稿が表示される' do
        expect(page).to have_content 'first post'
      end

      it '投稿詳細ページに編集、削除ボタンが表示されない' do
        visit item_path(user)
        expect(page).not_to have_content '編集'
        expect(page).not_to have_content '削除'
      end

      it "投稿詳細ページにメッセージを送るボタンが表示さる" do
        visit item_path(user)
        expect(page).to  have_css '.message_btn'
      end
    end
  end
end