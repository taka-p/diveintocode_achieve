class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

 protected

  def configure_permitted_parameters
    # strong parametersを設定し、nameを許可
    devise_parameter_sanitizer.for(:account_update)  << [:name, :image, :profile]
  end
end
