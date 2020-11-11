require 'rails_helper'
include NotificationsHelper

RSpec.describe 'User pages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  describe 'GET /new' do
    it '正常なレスポンスを返すこと' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    context 'ログイン済みのユーザーのとき' do
      it '正常なレスポンスを返すこと' do
        sign_in_as user
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    # ログインしていないユーザーの場合
    context 'ゲストユーザーのとき' do
      # アクセスに成功すること
      it '正常なレスポンスを返すこと' do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /edit' do
    context 'ログイン済みのユーザーのとき' do
      it '正常なレスポンスを返すこと' do
        sign_in_as user
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ゲストユーザーのとき' do
      it 'ログインページにリダイレクトされること' do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context 'other_userのとき' do
      it '投稿一覧ページにリダイレクトされること' do
        sign_in_as other_user
        get edit_user_path(user)
        expect(response).to redirect_to items_path
      end
    end
  end
end
