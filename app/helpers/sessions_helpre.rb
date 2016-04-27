module SessionHelper
  # ログインしているかの判定
  def signed_in?
    !current_user.nil?
  end

  # ログイン中のユーザ情報取得
  def current_user=(user)
    @current_user = user
  end

  # userがログイン中のユーザか判定
  def current_user?(user)
    user == current_user
  end

  # ログアウトを行う
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # sessionに前ページのの情報があればリダイレクト
  # 無ければdefaultページに遷移
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # redirect_back_orメソッド利用前にsessionに前ページを記録
  def store_location
    session[:return_to] = request.url
  end
end
