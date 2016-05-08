class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_notificatins
  protect_from_forgery with: :exception

  def current_notificatins
    @notifications = Notification.where(recipient_id: current_user.id)
                         .reverse_order.includes({ comment: [:blog] })
    @notifications_count =  Notification.where(recipient_id: current_user.id)
                                .reverse_order.unread.count
  end

  # 他のエラーハンドリングでキャッチできなかった場合に
  # 500 Internal Server Error(システムエラー)を発生させる
  # NOTE: rescue_from は下から評価されるので記載箇所はここが正解
  # rescue_from Exception, with: :handle_500 unless Rails.env.development?

  # 例外に合わせたエラーハンドリング
  # 404 Not Found リソースが見つからない。アクセス権がない場合にも使用される
  # rescue_from ActionController::RoutingError, with: :handle_404 unless Rails.env.development?
  # rescue_from ActiveRecord::RecordNotFound, with: :handle_404 unless Rails.env.development?
  #rescue_from ActiveRecord::RecordNotUnique, with: :render_409
  #rescue_from UnauthorizedError,             with: :render_401
  #rescue_from IllegalAccessError,            with: :render_403

  # エラーハンドリング処理
  # def handle_500(exception = nil)
  #   logger.info "Rendering 500 with exception: #{exception.message}" if exception
  #
  #   if request.xhr?
  #     # Ajaxのための処理
  #     render json: {error: '500 error'}, status: 500
  #   else
  #     render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  #   end
  # end

  # def handle_404(exception = nil)
  #   logger.info "Rendering 404 with exception: #{exception.message}" if exception
  #
  #   if request.xhr?
  #     # Ajaxのための処理
  #     render json: {error: '404 error'}, status: 404
  #   else
  #     render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  #   end
  # end

  protected

  def configure_permitted_parameters
    # strong parametersを設定し、nameを許可
    devise_parameter_sanitizer.for(:account_update) << [:name, :image, :profile]
  end
end
