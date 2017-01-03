Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true

  # devise用の指定
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings =
  {
      :user_name => ENV['RAILS_ACHIEVE_MAILER_USER_ID'],
      :password => ENV['RAILS_ACHIEVE_MAILER_PASSWORD'],
      :domain => "example.com",
      :address => "smtp.gmail.com",
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
  }

  BetterErrors::Middleware.allow_ip! '127.0.0.1'
end
