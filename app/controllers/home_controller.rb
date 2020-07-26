class HomeController < ApplicationController

  def home
    @items = Item.all
  end
end
