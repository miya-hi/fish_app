class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :if_not_admin
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "管理者権限を更新しました"
    else
      render :edit
    end
  end

  private

  def if_not_admin
    unless current_user && current_user.admin?
      redirect_to diaries_path, notice: "アクセス権限がありません"
    end
  end

  def user_params
    params.require(:user).permit(:admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
