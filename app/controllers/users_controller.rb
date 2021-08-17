class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def index
    redirect_to edit_user_registration_path
  end
end
