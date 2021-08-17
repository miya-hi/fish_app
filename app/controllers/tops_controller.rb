class TopsController < ApplicationController
  before_action :authenticate_user!, only: [:help]
  def index
  end

  def help
  end
end
