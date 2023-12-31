class Public::ReviewsController < ApplicationController
   before_action :authenticate_user!

  def create
    # フォーム送信成功時、showページに戻る際にproduct_idが必要なので、@productを定義
    @user = current_user
    @product = Product.find(params[:product_id])
    @review = Review.create(review_params)
    if @review.save
      flash[:notice] = "商品を評価しました"
      redirect_to user_products_path(@product.user)
    else
      flash[:alert] = "評価に失敗しました"
      redirect_to user_products_path(@product.user)
    end
  end

  private

  def review_params
    params.require(:review).permit(:all_rating).merge(
      user_id: current_user.id, product_id: params[:product_id]
    )
  end

end
