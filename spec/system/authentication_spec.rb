require 'rails_helper'
#include OmniauthMocks

RSpec.describe 'Twitterログイン', type: :system do
  pending 'OmniauthMocksモジュールをincludeするとテストに成功するが、他のシステムスペックのテストがすべて失敗してしまう'
  xdescribe 'Twitterログイン処理' do
    before do
      visit login_path
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = nil
    end

    context '有効なユーザーだったとき' do
      it 'ユーザーはTwitter認証に成功すること' do
        Rails.application.env_config['omniauth.auth'] = twitter_mock
        click_on 'twitterアカウントでログイン'
        expect(page).to have_content('Twitterログインに成功しました。')
      end
    end

    context '無効なユーザーだったとき' do
      it 'ユーザーは認証に失敗すること' do
        Rails.application.env_config['omniauth.auth'] = twitter_invalid_mock
        click_on 'twitterアカウントでログイン'
        expect(page).to_not have_content('Twitterログインに成功しました。')
      end
    end
  end
end
