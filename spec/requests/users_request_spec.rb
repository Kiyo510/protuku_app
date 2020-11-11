require 'rails_helper'
include NotificationsHelper

RSpec.describe 'User pages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  describe 'GET /new' do
    # 正常なレスポンスを返すこと
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    # ログイン済みのユーザーとして
    context 'as an authenticated user' do
      # 正常なレスポンスを返すこと
      it 'responds successfully' do
        sign_in_as user
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    # ログインしていないユーザーの場合
    context 'as a guest' do
      # アクセスに成功すること
      it 'redirects to the login page' do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /edit' do
    context 'as an authenticated user' do
      it 'responds successfully' do
        sign_in_as user
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'as a guest' do
      it 'redirects to the login page' do
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'as a other_user' do
      it 'redirects to the items page' do
        sign_in_as other_user
        get edit_user_path(user)
        expect(response).to redirect_to items_path
      end
    end
  end
end
