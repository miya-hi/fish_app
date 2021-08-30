class FishesController < ApplicationController
  before_action :authenticate_user!

  def index
    @fishes = Fish.where(line:["あ","い","う","え","お"])
  end
end
