# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item, user_id: user.id) }
  let(:other_user) { FactoryBot.create(:other_user) }

  describe 'GET /new' do
    context 'ログイン済みのユーザーのとき ' do
      it 'アクセスに成功すること' do
        sign_in_as user
        get new_item_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしてないユーザーのとき' do
      it 'ログイン画面へリダイレクトすること' do
        get new_item_path
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET /show' do
    context 'ログイン済みのユーザーのとき' do
      it 'アクセスに成功すること' do
        sign_in_as user
        get item_path(item)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていないユーザーのとき' do
      it 'アクセスに成功すること' do
        get item_path(item)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /edit' do
    context '権限を持ったユーザーのとき' do
      it 'アクセスに成功すること' do
        sign_in_as user
        get edit_item_path(item)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていないユーザーのとき' do
      it 'ログイン画面へリダイレクトすること' do
        get edit_item_path(item)
        expect(response).to redirect_to login_path
      end
    end

    context '権限を持ってないユーザーのとき' do
      it '投稿一覧ページへリダイレクトすること' do
        sign_in_as other_user
        get edit_item_path(item)
        expect(response).to redirect_to items_path
      end
    end
  end

  describe 'GET /update' do
    context '権限を持ったユーザーのとき' do
      it '投稿の更新に成功すること' do
        item_params = FactoryBot.attributes_for(:item, content: 'NewContent', tag_name: 'NewTag')
        sign_in_as user
        patch item_path(item), params: { id: item.id, item: item_params }
        expect(item.reload.content).to eq 'NewContent'
      end
    end

    context 'ログインしていないユーザーのとき' do
      it 'ログイン画面へリダイレクトすること' do
        item_params = FactoryBot.attributes_for(:item, content: 'NewContent', tag_name: 'NewTag')
        patch item_path(item), params: { id: item.id, item: item_params }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to login_path
      end
    end

    context '権限を持ってないユーザーのとき' do
      it '他のuserの投稿の更新に失敗すること' do
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
