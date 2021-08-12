class FavoritesController < ApplicationController
  def new
    @fishes = Fish.all
  end
  def create
    favorite = current_user.favorites.create(fish_id: params[:fish_id])
    redirect_to new_diaries_path, notice: "#{favorite.fish.}をお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to new_diaries_path, notice: "#{favorite.fish.name}のお気に入りを解除しました"
  end
end
