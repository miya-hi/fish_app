class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  def index
    @diaries = Diary.all
  end
  def new
    @diary = Diary.new
    @fishes = Fish.all
  end
  def create
    @diary = current_user.diaries.build(diary_params)
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
  private
  def diary_params
    params.require(:diary).permit(:user_id, :fish_id, :amount, :input_at)
  end
  def set_diary
    @diary = Diary.find(params[:id])
  end
end
