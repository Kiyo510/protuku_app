RSpec.feature 'ストック（お気に入り）機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:item) { FactoryBot.create(:item, user_id: other_user.id, title: "stock_test") }

  before do
    valid_login(user)
    visit item_path(item)
    first('.fa-check-square').click
  end

  context "userがストックボタンを押したとき" do
    it "userのマイページにストック履歴が追加されること" do
      visit user_path(user)
      expect(page).to have_content "#{other_user.nickname}の投稿"
      expect(page).to have_content "stock_test"
    end
  end

  context "userがストックを解除したとき" do
    it "userのマイページからストック履歴が削除されること" do
      # もう一度ストックボタンを押す
      first('.fa-check-square-o').click
      visit user_path(user)
      expect(page).not_to have_content "#{other_user.nickname}の投稿"
      expect(page).not_to have_content "stock_test"
    end
  end
end
