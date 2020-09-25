require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /" do
    context "userがログイン済みのとき" do
      it "投稿一覧ページにリダイレクトされる" do
        sign_in_as user
        get root_path
        expect(response).to redirect_to items_path
      end
    end
  end

end
