require 'rails_helper'
include NotificationsHelper

RSpec.describe 'Items', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item, user_id: user.id) }
  let(:other_user) { FactoryBot.create(:other_user) }

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

    context 'as an ohter uesr' do
      it 'redirects to the items page' do
        sign_in_as other_user
        get edit_item_path(item)
        expect(response).to redirect_to items_path
      end
    end
  end

  describe 'GET /update' do
    context 'as an authorized user' do
      it 'updates a item' do
        item_params = FactoryBot.attributes_for(:item, content: 'NewContent', tag_name: 'NewTag')
        sign_in_as user
        patch item_path(item), params: { id: item.id, item: item_params }
        expect(item.reload.content).to eq 'NewContent'
      end
    end

    context 'as a guest' do
      it 'redirect to the login page' do
        item_params = FactoryBot.attributes_for(:item, content: 'NewContent', tag_name: 'NewTag')
        patch item_path(item), params: { id: item.id, item: item_params }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to login_path
      end
    end

    context 'as other user' do
      it 'does not update the user' do
        item_params = FactoryBot.attributes_for(:item, content: 'NewContent', tag_name: 'NewTag')
        item_by_other_user = FactoryBot.create(:item, user_id: other_user.id)
        sign_in_as other_user
        patch item_path(item), params: { id: item.id, item: item_params }
        expect(item.reload.content).to eq item_by_other_user.content
        expect(response).to redirect_to items_path
      end
    end
  end
end
