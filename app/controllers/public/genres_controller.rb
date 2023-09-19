class Public::GenresController < ApplicationController
   before_action :authenticate_user!

  def show
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @genre_pages = @genre.products.where(is_secret: true).order("created_at DESC").page(params[:page])
  end
end
