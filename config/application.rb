require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require(*Rails.groups(:assets => %w(development test)))

module Achieve
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :ja

    config.active_record.raise_in_transactional_callbacks = true

    # devise用
    config.assets.initialize_on_precompile = false

    # carriewave用
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]

    # precompile設定
    Rails.application.config.assets.precompile += %w(*.eot *.woff *.ttf *.svg *.otf *.png *.jpg *.jpeg *.gif vendor.css vendor.js)
  end
end
