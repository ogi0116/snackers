class Public::ReviewsController < ApplicationController

  def create
    # フォーム送信成功時、showページに戻る際にproduct_idが必要なので、@productを定義
    @user = current_user
    @product = Product.find(params[:product_id])
    @review = Review.create(review_params)
    if @review.save
      redirect_to user_products_path(@product.user)
    else
      @product = @review.product
      @reviews = @product.reviews
      render :show
    end
  end

  private

  def review_params
    params.require(:review).permit(:all_rating).merge(
      user_id: current_user.id, product_id: params[:product_id]
    )
  end

end
