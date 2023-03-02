class ReviewsController < ApplicationController
  def index
    @animation = Animation.find(params[:animation_id])
    @reviews = @animation.reviews.order(created_at: :desc).page(params[:page]).per(10)
    @user = current_user
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @animation = Animation.find(params[:animation_id])
    if @review.save
      redirect_to animation_reviews_path(@review.animation)
    else
      render template: "animations/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def review_params
    params.require(:review).permit(:animation_id, :content, :score)
  end
end
