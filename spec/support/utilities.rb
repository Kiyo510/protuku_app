# frozen_string_literal: true

# ログインする
def sign_in_as(user)
  post login_path, params: { session: { email: user.email,
                                        password: user.password } }
end

def is_logged_in?
  !current_user.nil?
end

def current_user
  if (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies.signed[:user_id])
    user = User.find_by(id: user_id)
    if user&.authenticated?(:remember, cookies[:remember_token])
      log_in user
      @current_user = user
    end
  end
end
