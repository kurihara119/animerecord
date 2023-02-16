require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:animation) { create(:animation) }
  let(:reviews) { create_list(:review, 11, animation: animation) }
  let(:user) { create(:user) }

  describe '#index' do
    before do
      sign_in user
      get animation_reviews_path(reviews[0].id)
    end

    it '正常にレスポンスを返すこと' do
      expect(response).to have_http_status(:success)
    end

    it 'レビューの情報を取得すること' do
      expect(response.body).to include(
        reviews[0].content,
        reviews[0].score.to_s
      )
    end

    it 'ユーザーの画像を取得すること' do
      expect(response.body).to include('test_user.png')
    end

    it "レビューを10件取得すること" do
      expect(Capybara.string(response.body)).to have_selector ".reviewer-name", count: 10
    end

    it "11件目のレビューを取得しないこと" do
      expect(Capybara.string(response.body)).not_to have_selector ".reviewer-name", count: 11
    end
  end

  describe '#new' do
    before do
      sign_in user
      get animation_path(reviews[0].id)
    end

    it '正常にレスポンスを返すこと' do
      expect(response).to have_http_status(:success)
    end
  end
end
