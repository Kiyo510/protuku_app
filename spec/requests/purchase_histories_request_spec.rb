require 'rails_helper'

RSpec.describe 'PurchaseHistories', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/purchase_histories/index'
      expect(response).to have_http_status(:success)
    end
  end
end
