require_relative 'boot'

require "rails"
# Pick the frameworks you want:
# require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/engine"
# # require "sprockets/railtie"
# require "rails/test_unit/railtie"

%w(
  active_record/railtie
  action_controller/railtie
  active_job/railtie
).each do |railtie|
  require railtie
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AiEsports
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.autoload_paths += Dir["#{Rails.root}/app/models/series"]
    config.autoload_paths += Dir["#{Rails.root}/app/models/teams"]
    config.autoload_paths += Dir["#{Rails.root}/app/models/matches"]
    config.autoload_paths += Dir["#{Rails.root}/app/models/lives"]
    config.api_only = true

    ActiveModelSerializers.config.adapter = :json
  end
end
