class UsersController < ApplicationController

  def show
  end
  
  def index
    redirect_to edit_user_registration_path
  end
end
