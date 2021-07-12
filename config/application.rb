# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ELearning
  class Application < Rails::Application # rubocop:todo Style/Documentation
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    Rails::Html::WhiteListSanitizer.allowed_tags << 'iframe'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.to_prepare do
      ActionText::ContentHelper.allowed_tags << 'iframe'
    end

    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]

    config.assets.initialize_on_precompile = false
  end
end
