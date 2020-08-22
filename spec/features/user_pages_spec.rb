require 'rails_helper'

RSpec.feature "UserPages", type: :feature do
  describe "signup page" do
    before do
      visit user_path(user)
    end
  end

#   it "should have the content '自己紹介'" do
#     expect(page).to have_content "自己紹介"
#   end

#   it "should have the right title" do
#     expect(page).to have_title 'マイページ'
#   end
end
