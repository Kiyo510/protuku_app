# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Homes', type: :system do
  let(:user) { FactoryBot.create(:user) }
  describe 'TOPページの表示' do
    context 'userがログインしていないとき' do
      it 'ヘッダーにユーザー登録、ログインボタンが表示されること' do
        visit root_path
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'ログイン'
      end
    end
  end
end
