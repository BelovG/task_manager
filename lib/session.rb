module Session
  def current_user
    return nil unless cookies[:remember_token]
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    current_user.present?
  end
end