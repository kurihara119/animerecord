require 'rails_helper'

RSpec.describe 'Records', type: :request do
  let(:record) { create(:record) }
  let(:user) { create(:user) }

  describe '#index' do
    before do
      sign_in user
      get records_path
    end

    it '正常にレスポンスを返すこと' do
      expect(response).to have_http_status(:success)
    end

    it '記録した作品の情報を取得すること' do
      expect(response.body).to include(record.record_animationname)
    end
  end
end
