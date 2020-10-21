require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /new' do
    it 'アクセスに成功すること' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
