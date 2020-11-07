RSpec.feature 'タグ機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:tag) { FactoryBot.create(:tag) }
  let!(:tagmap) { FactoryBot.create(:tagmap) }

  before do
    valid_login(user)
  end

  it '入力されたタグが正しく表示されること' do
    visit items_path
    expect(page).to have_content tag.tag_name
  end

  context '同じタグが入力されたとき' do
    it '重複してtag_nameカラムに保存されないこと' do
      expect do
        visit new_item_path
        fill_in 'item[title]',	with: 'test'
        fill_in 'item[tag_name]',	with: 'same_tag'
        select '東京都', from: 'item[prefecture_id]'
        fill_in 'item[content]',	with: 'testcontent'
        click_on '投稿する'
        visit new_item_path
        fill_in 'item[title]',	with: 'test'
        fill_in 'item[tag_name]',	with: 'same_tag'
        select '東京都', from: 'item[prefecture_id]'
        fill_in 'item[content]',	with: 'testcontent'
        click_on '投稿する'
      end.to change(Tag, :count).by(1)
    end
  end
end
