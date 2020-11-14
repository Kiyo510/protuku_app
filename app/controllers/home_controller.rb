# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :forbid_login_user

  def home
    @items = Item.includes(:user).order('created_at DESC').limit(20)
  end
end
