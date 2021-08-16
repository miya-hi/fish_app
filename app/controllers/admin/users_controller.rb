class Admin::UsersController < ApplicationController
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
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:admin)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
