class HomeController < ApplicationController
  before_action :forbid_login_user

  def home
    @items = Item.all.order(created_at: :desc)
  end
end
