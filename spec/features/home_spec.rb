require 'rails_helper'

RSpec.feature 'Homes', type: :feature do
  describe 'Home page' do
    before do
      visit root_path
    end
  end

  it "shoule have the content 'タイトル'" do
    expect(page).to have_content 'タイトル'
  end
  it "shoule have the content 'ユーザー登録'" do
    expect(page).to have_content 'ユーザー登録'
  end
end
