# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Twitterログイン', type: :system do
  describe 'Twitterログイン処理' do
    before do
      visit login_path
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = nil
    end

    context '有効なユーザーだったとき' do
      it 'ユーザーはTwitter認証に成功すること' do
        twitter_mock
        click_on 'twitterアカウントでログイン'
        expect(page).to have_content('Twitterログインに成功しました。')
      end
    end

    context '無効なユーザーだったとき' do
      it 'ユーザーは認証に失敗すること' do
        twitter_invalid_mock
        click_on 'twitterアカウントでログイン'
        expect(page).to_not have_content('Twitterログインに成功しました。')
      end
    end
  end
end
