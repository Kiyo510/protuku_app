# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User pages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

  describe '新規登録画面' do
    it '正常なレスポンスを返すこと' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'マイページ' do
    context 'ログイン済みのユーザーのとき' do
      it '正常なレスポンスを返すこと' do
        sign_in_as user
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ゲストユーザーのとき' do
      it '正常なレスポンスを返すこと' do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'ユーザー情報編集画面' do
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

    context '権限をもったユーザーであるとき' do
      it 'ユーザー情報を更新できること' do
        user_params = FactoryBot.attributes_for(:user, nickname: 'New_nickname', email: 'new_email@exemple.com',
                                                       password: 'new_password', introduction: 'new_introduction')
        sign_in_as user
        old_password_digest = user.password_digest
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.nickname).to eq 'New_nickname'
        expect(user.reload.email).to eq 'new_email@exemple.com'
        expect(user.reload.password_digest).not_to eq old_password_digest
        expect(user.reload.introduction).to eq 'new_introduction'
      end
    end

    context 'ゲストユーザーの場合' do
      it 'ログイン画面にリダイレクトすること' do
        user_params = FactoryBot.attributes_for(:user, nickname: 'New_nickname', email: 'new_email@exemple.com',
                                                       password: 'new_password', introduction: 'new_introduction')
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to login_path
      end
    end

    context 'アカウントが違うユーザーのとき' do
      it 'ユーザーの更新に失敗すること' do
        user_params = FactoryBot.attributes_for(:user, nickname: 'New_nickname', email: 'new_email@exemple.com',
                                                       password: 'new_password', introduction: 'new_introduction')
        sign_in_as other_user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.nickname).to eq user.nickname
        expect(user.reload.email).to eq user.email
        expect(user.reload.password).to eq user.password
        expect(user.reload.introduction).to eq user.introduction
      end

      it 'ログイン画面にリダイレクトすること' do
        user_params = FactoryBot.attributes_for(:user, nickname: 'New_nickname', email: 'new_email@exemple.com',
                                                       password: 'new_password', introduction: 'new_introduction')
        sign_in_as other_user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to redirect_to items_path
      end
    end
  end
end
