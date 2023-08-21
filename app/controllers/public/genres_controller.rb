class Public::GenresController < ApplicationController

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genre_pages = @genre.products.order("created_at DESC").page(params[:page])
  end
end
