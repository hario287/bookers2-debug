class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # @book = Book.find(params[:book_id])
    # favorite = current_user.favorites.new(book_id: @book.id)
    # favorite.save
    @book_favorite = Favorite.new(user_id: current_user.id, book_id: params[:post_id])
    @book_favorite.save
    redirect_to book_path(params[:book_id])
  end

  def destroy
    # @book = Book.find(params[:book_id])
    # favorite = current_user.favorites.new(book_id: @book.id)
    # favorite.destroy
    @book_favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:post_id])
    @book_favorite.destroy
    redirect_to book_path(params[:book_id])
  end

end
