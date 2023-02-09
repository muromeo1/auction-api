require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_cable/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'

Bundler.require(*Rails.groups)

module AuctionInterview
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths << Rails.root.join('lib')
    config.api_only = true
  end
end
