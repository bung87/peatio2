require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Peatio
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.i18n.enforce_available_locales = false

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'custom', '*.{yml}')]
    #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = ['en', 'zh-CN']
    #config.i18n.available_locales = ['en', 'ru']
    #config.i18n.available_locales = ['en']

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/lib/extras)

    #config.assets.precompile += ['bootstrap-datetimepicker.css']
    config.assets.initialize_on_precompile = true
    config.active_record.raise_in_transactional_callbacks = true
    # Precompile all available locales
    Dir.glob("#{config.root}/app/assets/javascripts/locales/*.js.erb").each do |file|
      config.assets.precompile << "locales/#{file.match(/([a-z\-A-Z]+\.js)\.erb$/)[1]}"
    end

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.stylesheets     false
    end

    # Observer configuration
    config.active_record.observers = :transfer_observer

    config.angular_templates.module_name    = 'templates'
    # config.angular_templates.ignore_prefix  = 'templates/'
    config.angular_templates.inside_paths   = ['app/assets']
    config.angular_templates.markups        = %w(erb slim)
    config.angular_templates.extension      = 'html'  

  end
end
