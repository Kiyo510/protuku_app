require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item) }

  describe 'GET /new' do
    # ログイン済みのユーザーはアクセスに成功する
    context 'as an authenticated user ' do
      it 'returns http success' do
        sign_in_as user
        get new_item_path
        expect(response).to have_http_status(:success)
      end
    end

    # ログインしてないユーザーはログイン画面へリダイレクト
    context 'as a guest' do
      it 'redirects to the login page' do
        get new_item_path
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET /show' do
    context 'as an authenticated user' do
      it 'returns http success' do
        sign_in_as user
        get item_path(item)
        expect(response).to have_http_status(:success)
      end
    end

    context 'as a guest' do
      it 'redirects to the login page' do
        get item_path(item)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET /edit' do
    context 'as an authenticated user' do
      it 'returns http success' do
        sign_in_as user
        get edit_item_path(item)
        expect(response).to have_http_status(:success)
      end
    end

    context 'as a guest' do
      it 'redirects to the login page' do
        get edit_item_path(item)
        expect(response).to redirect_to login_path
      end
    end
  end
end
