require 'rails_helper'

RSpec.describe'UploadImage', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item) }

  #画像をアップロードして保存する
  def upload_user_avatar(user)
    valid_login(user)
    visit edit_user_path(user)
    attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/images/test.jpg"
    click_on '保存する'
  end

  it 'user successfully upload image user#show' do
    upload_user_avatar(user)
    expect(page).to have_selector("img[src$='test.jpg']")
  end

  it 'user successfully upload image on item#show' do
    upload_user_avatar(user)
    visit item_path(item)
    page.save_screenshot 'screenshot.png'
    expect(page).to have_selector("img[src$='test.jpg']")
  end
end