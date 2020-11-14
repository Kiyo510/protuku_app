# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  let(:user) { create(:user) }

  describe 'POST /password_resets' do
    context '無効なメールアドレスが送信された時' do
      it 'ユーザーはメールの送信に失敗すること' do
        get new_password_reset_path
        expect(request.fullpath).to eq '/password_resets/new'
        post password_resets_path, params: { password_reset: { email: '' } }
        expect(flash[:danger]).to be_truthy
        expect(request.fullpath).to eq '/password_resets'
      end
    end

    context '有効なメールアドレスが送信されたとき' do
      it 'userはメールの送信に成功すること' do
        get new_password_reset_path
        expect(request.fullpath).to eq '/password_resets/new'
        post password_resets_path, params: { password_reset: { email: user.email } }
        expect(flash[:success]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/'
      end
    end
  end

  describe 'GET /password_resets/:id/edit' do
    context '不正なメールアドレスだったとき' do
      it 'userはパスワード再設定ページへリダイレクトされること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        get edit_password_reset_path(user.reset_token, email: '')
        expect(flash[:danger]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/password_resets/new'
      end
    end

    context '不正なuserだったとき' do
      it 'userはパスワード再設定ページへリダイレクトされること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        user.toggle!(:activated)
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(flash[:danger]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/password_resets/new'
        user.toggle!(:activated)
      end
    end

    context '不正なトークンだったとき' do
      it 'uesrはパスワード再設定ページへリダイレクトされること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        get edit_password_reset_path('wrong token', email: user.email)
        expect(flash[:danger]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/password_resets/new'
      end
    end

    context '有効なパラメータだったとき' do
      it 'userは編集ページへのアクセスに成功すること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(flash[:danger]).to be_falsey
        expect(request.fullpath).to eq "/password_resets/#{user.reset_token}/edit?email=#{CGI.escape(user.email)}"
      end
    end
  end

  describe 'PATCH /password_resets/:id' do
    context 'パスワード確認が不一致だったとき' do
      it 'userはパスワードの更新に失敗すること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        get edit_password_reset_path(user.reset_token, email: user.email)
        patch password_reset_path(user.reset_token), params: {
          email: user.email,
          user: {
            password: 'foobaz',
            password_confirmation: 'barquux'
          }
        }
        expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
      end
    end

    context 'パスワードが空欄だったとき' do
      it 'userはパスワードの更新に失敗すること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        get edit_password_reset_path(user.reset_token, email: user.email)
        patch password_reset_path(user.reset_token), params: {
          email: user.email,
          user: {
            password: '',
            password_confirmation: ''
          }
        }
        expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
      end
    end

    context '期限切れのトークンだったとき' do
      it 'userはパスワード再設定ページへリダイレクトされること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        user.update_attribute(:reset_sent_at, 3.hours.ago)
        get edit_password_reset_path(user.reset_token, email: user.email)
        patch password_reset_path(user.reset_token), params: {
          email: user.email,
          user: {
            password: 'foobaz',
            password_confirmation: 'foobaz'
          }
        }
        expect(flash[:danger]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/password_resets/new'
      end
    end

    context '有効なパラメータが送信されたとき' do
      it 'userはログインに成功すること' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user = controller.instance_variable_get('@user')
        get edit_password_reset_path(user.reset_token, email: user.email)
        patch password_reset_path(user.reset_token), params: {
          email: user.email,
          user: {
            password: 'foobaz',
            password_confirmation: 'foobaz'
          }
        }
        expect(flash[:success]).to be_truthy
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq user_path(user)
      end
    end
  end
end
