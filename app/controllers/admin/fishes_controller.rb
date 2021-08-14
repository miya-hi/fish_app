class Admin::FishesController < ApplicationController
  before_action :if_not_admin
  before_action :set_fish, only: [:edit, :update, :destroy]
  def index
    @fishes = Fish.all
  end
  def new
    @fish = Fish.new
  end
  def create
    @fish = Fish.new(fish_params)
      if @fish.save
        redirect_to admin_fishes_path, notice: "新しい魚を登録しました"
      else
        render :new
      end
  end
  def edit
  end
  def update
    if @fish.update(fish_params)
      redirect_to admin_fishes_path, notice: "魚の情報を更新しました"
    else
      render :edit
    end
  end
  def destroy
    @fish.destroy
    redirect_to admin_fishes_path, notice: "魚を削除しました"
  end
  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
  def fish_params
    params.require(:fish).permit(:name, :line, :n3_oil, :vitamin_a, :mercury, :content, :image)
  end
  def set_fish
    @fish = Fish.find(params[:id])
  end
end
