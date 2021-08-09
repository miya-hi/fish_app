class DiariesController < ApplicationController
  before_action :authenticate_user!
  def index
    @diaries = Diary.all
    @diary = Diary.new
  end

end
