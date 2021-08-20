class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:edit, :update, :destroy]

  def index
    @diaries = current_user.diaries
    @summary_diaries = current_user.diaries.where(input_at: (Date.today.ago(1.week)..Date.today))
    @total_mercury = @summary_diaries.sum{|d| d.amount.to_i * d.fish.mercury.to_f / 100}
    @total_n3_oil = @summary_diaries.sum{|d| d.amount.to_i * d.fish.n3_oil.to_f / 100}
  end

  def new
    @diary = Diary.new
    @diary.input_at = Date.parse(params[:input_at]) if params[:input_at].present?
    @fishes = Fish.all
    @favorites = current_user.favorites
    @favorite_fishes = current_user.favorite_fishes
  end

  def create
    @fishes = Fish.all
    @favorite_fishes = current_user.favorite_fishes
    @diary = current_user.diaries.build(diary_favorite_params)
    @diary.input_at = Date.today if @diary.input_at.blank?
    if @diary.save
        if params[:register_favorite] == "true"
          current_user.favorites.where(fish_id: @diary.fish_id).first_or_create
        end
      redirect_to diaries_path, notice: "作成しました"
    else
    render :new
    end
  end

  def show
    @diaries = current_user.diaries.where(input_at: params[:id]).order(id: :asc)
    @input_at = Date.parse(params[:id])
  end

  def edit
    @fishes = Fish.all
    @favorites = current_user.favorites
    @favorite_fishes = current_user.favorite_fishes
  end

  def update
    @fishes = Fish.all
    @favorite_fishes = current_user.favorite_fishes
    if @diary.update(diary_params)
      redirect_to diary_path(@diary.input_at.strftime('%Y-%m-%d')), notice:"編集しました"
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_path, notice:"削除しました"
  end

  private

  def diary_params
    params.require(:diary).permit(:fish_id, :amount, :input_at)
  end
  def diary_favorite_params
    if params[:favorite][:fish_id].present?
      params[:diary][:fish_id] = params[:favorite][:fish_id]
    end
    params.require(:diary).permit(:fish_id, :amount, :input_at)
  end
  def set_diary
    @diary = Diary.find(params[:id])
  end
end
