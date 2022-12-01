require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Buddies
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # config.time_zone = 'Eastern Time (US & Canada)'
    # config.assets.initialize_on_precompile = false
    config.action_mailer.default_url_options = {:host => 'buddies-test.herokuapp.com' }
  
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default :charset => "utf-8"
  
    config.action_mailer.smtp_settings = {
      :address              => 'smtp.sendgrid.net',
      :port                 =>  25,
      :domain               => 'heroku.com',
      :user_name            => ENV["SENDGRID_USERNAME"],
      :password             => ENV["SENDGRID_PASSWORD"],
      :authentication       => 'plain',
      :enable_starttls_auto => true
    }
  end
end