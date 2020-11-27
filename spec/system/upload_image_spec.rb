# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '画像のアップロード', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item, user_id: user.id) }

  before do
    valid_login(user)
  end

  # 画像をアップロードして保存する
  def upload_user_avatar(user)
    visit edit_user_path(user)
    attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/images/test.jpg"
    click_on '変更を保存'
  end

  it 'userがアップロードした画像がマイページに表示されること' do
    upload_user_avatar(user)
    expect(page).to have_selector("img[src$='test.jpg']")
  end

  describe "画像アップロード機能" do
    context "userがプロフィール画像をアップロードしたとき" do
      it 'プロフィール画像がマイページに表示されること' do
        upload_user_avatar(user)
        expect(page).to have_selector("img[src$='test.jpg']")
      end

      it 'プロフィール画像が投稿詳細ページに表示されること' do
        upload_user_avatar(user)
        visit item_path(item)
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end

    context "userがプロフィール画像を更新したとき" do
      it 'プロフィール画像の更新に成功すること' do
        visit edit_user_path(user)
        attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/images/updated_test.jpg"
        click_on '変更を保存'
        expect(page).to have_selector("img[src$='updated_test.jpg']")
      end
    end

    context "プロフィール画像はアップロードせずに更新したとき" do
      it 'デフォルトのプロフィール画像データで上書きされないこと' do
        upload_user_avatar(user)
        visit edit_user_path(user)
        click_on '変更を保存'
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end

    context "userが投稿画像をアップロードしたとき" do
      it '投稿画像が投稿一覧ページに表示されること' do
        upload_item_image
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end

  it 'userが画像の更新に成功すること' do
    visit edit_user_path(user)
    attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/images/updated_test.jpg"
    click_on '変更を保存'
    expect(page).to have_selector("img[src$='updated_test.jpg']")
  end

    context "編集時に投稿画像はアップロードせずに更新したとき" do
      it '空の投稿画像データで上書きされないこと' do
        upload_item_image
        visit edit_item_path(item)
        click_on '更新する'
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end
  end
end
