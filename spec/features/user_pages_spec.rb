require 'rails_helper'

RSpec.feature "UserPages", type: :feature do
  describe "signup page" do
    before do
      visit signup_path
  end

  it "should have the content 'ユーザー登録'" do
    expect(page).to have_content "ユーザー登録"
  end

  it "should have the right title" do
    expect(page).to have_title 'Sign up'
  end
end
