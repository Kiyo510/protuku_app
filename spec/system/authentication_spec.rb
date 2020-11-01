require 'rails_helper'

RSpec.describe 'Twitterログイン', type: :system do
  describe 'Twitterログイン処理' do
    let!(:twitter_client) { FactoryBot.create(:twitter_client) }

    before do
      visit login_path
      OmniAuth.config.mock_auth[:twitter] = nil
    end

    context "有効なユーザーだったとき" do
      it 'ユーザーはTwitter認証に成功すること' do
        Rails.application.env_config['omniauth.auth'] = twitter_mock(
          twitter_client.nickname,
          twitter_client.email,
        )
        click_link 'twitterアカウントでログイン'
        expect(page).to have_content('Twitterログインに成功しました。')
      end
    end

    context "無効なユーザーだったとき" do
      it 'ユーザーは認証に失敗すること' do
        Rails.application.env_config['omniauth.auth'] = twitter_invalid_mock
        click_link 'twitterアカウントでログイン'
        expect(page).to_not have_content('Twitterログインに成功しました。')
      end
    end
  end
end
