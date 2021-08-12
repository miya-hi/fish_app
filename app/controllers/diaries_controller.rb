class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:edit, :update, :destroy]

  def index
    @diaries = current_user.diaries
    @summary_diaries = current_user.diaries.where(input_at: (Date.today.ago(1.week)..Date.today))
    @total_mercury = @summary_diaries.sum{|d| d.amount.to_i * d.fish.mercury.to_f / 100}
  end

  def new
    @diary = Diary.new
    @fishes = Fish.all
    @favorites = current_user.favorites
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    @diary.input_at = Date.today if @diary.input_at.blank?
    @diary.save!
    redirect_to diary_path(@diary.input_at.strftime('%Y-%m-%d')), notice: "作成しました" and return
  end

  def show
    @diaries = current_user.diaries.where(input_at: params[:id]).order(id: :asc)
    @input_at = Date.parse(params[:id])
  end

  def edit
    @fishes = Fish.all
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
