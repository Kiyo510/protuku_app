require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  describe "Home page" do
    before do
      visit root_path
  end

  it "shoule have the content 'WEBAPPとは？'" do
    expect(page).to have_content "WEBAPPとは？"
  end
  it "shoule have the content '新規登録'" do
    expect(page).to have_content "新規登録"
  end
end
