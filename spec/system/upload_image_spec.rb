require 'rails_helper'
include NotificationsHelper

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

  it 'userがアップロードした画像が投稿詳細ページに表示されること' do
    upload_user_avatar(user)
    visit item_path(item)
    expect(page).to have_selector("img[src$='test.jpg']")
  end

  it 'userが画像の更新に成功すること' do
    visit edit_user_path(user)
    attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/images/updated_test.jpg"
    click_on '変更を保存'
    expect(page).to have_selector("img[src$='updated_test.jpg']")
  end

  it '画像をアップロードせずに編集したとき、デフォルトの画像データで上書きされないこと' do
    upload_user_avatar(user)
    visit edit_user_path(user)
    click_on '変更を保存'
    expect(page).to have_selector("img[src$='test.jpg']")
  end
end
