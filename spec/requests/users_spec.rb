require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  describe 'POST /sessions' do
    describe '#sign_up' do
      before do
        get new_user_registration_path
      end

      it '正常にレスポンスを返すこと' do
        expect(response).to have_http_status(:success)
      end
    end

    describe '#sign_in' do
      before do
        get new_user_session_path
      end

      it '正常にレスポンスを返すこと' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
