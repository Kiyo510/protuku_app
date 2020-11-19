# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Twitterログイン', type: :system do
  describe 'Twitterログイン処理' do
    before do
      visit login_path
      OmniAuth.config.test_mode = true
    end

    after do
      Rails.application.env_config['omniauth.auth'] = nil
    end

    context '有効なユーザーだったとき' do
      it 'ユーザーはTwitter認証に成功すること' do
        Rails.application.env_config['omniauth.auth'] = twitter_mock
        click_on 'twitterアカウントでログイン'
        expect(page).to have_css '.uk-alert-success'
        expect(page).to have_content 'Twitterログインに成功しました。'
      end
    end

    context '無効なユーザーだったとき' do
      it 'ユーザーは認証に失敗すること' do
        Rails.application.env_config['omniauth.auth'] = twitter_invalid_mock
        click_on 'twitterアカウントでログイン'
        expect(page).to_not have_content 'Twitterログインに成功しました。'
      end
    end
  end
end
