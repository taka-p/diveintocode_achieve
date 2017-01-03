Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :scss
  config.assets.digest = true
  config.serve_static_files = true
  # prpductionでのprecompileを有効に設定（処理が重いため代替策が必要）
  config.assets.compile = true

  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false

  # devise用
  config.action_mailer.default_url_options = { host: ENV['MAILER_URL_OPTION_HOST'] }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings =
  {
      :user_name => ENV['RAILS_ACHIEVE_MAILER_USER_ID'],
      :password => ENV['RAILS_ACHIEVE_MAILER_PASSWORD'],
      :domain => "smtp.gmail.com",
      :address => "smtp.gmail.com",
      :port => 587,
      :authentication => 'login',
      :enable_starttls_auto => true
  }
end
