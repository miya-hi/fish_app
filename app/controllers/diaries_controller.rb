class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:edit, :update, :destroy]

  def index
    @diaries = Diary.all
  end

  def new
    @diary = Diary.new
    @fishes = Fish.all
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    @diary.input_at = Date.today if @diary.input_at.blank?
    @diary.save!
    redirect_to diary_path(@diary.input_at.strftime('%Y-%m-%d')), notice: "作成しました" and return
  end

  def show
    # idには YYYY-MM-DD の日付が入ってくる
    @diaries = current_user.diaries.where(input_at: params[:id]).order(id: :asc)
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      redirect_to diaries_path, notice:"編集しました"
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
  def set_diary
    @diary = Diary.find(params[:id])
  end
end
