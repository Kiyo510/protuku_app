class HomeController < ApplicationController

  def home
    @items = Item.all.order(created_at: :desc)
    @user = User.new
  end
end
