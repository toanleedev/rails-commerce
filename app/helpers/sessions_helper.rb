module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    user_id = session[:user_id] || cookies.signed[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

  def current_user?(user)
    user.id == current_user.id
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
    cookies.delete :user_id
    @current_user = nil
  end

  def remember(user)
    cookies.signed[:user_id] = { value: user.id, expires: 2.weeks.from_now }
  end
end
