# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :forbid_login_user

  def home
    @items = Item.preload(:user, user: { avatar_attachment: :blob })
                 .with_attached_image.order('items.created_at DESC').limit(20)
  end
end
