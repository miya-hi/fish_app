class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to favorites_path, notice: "#{favorite.fish.name}のお気に入りを削除しました"
  end
end
