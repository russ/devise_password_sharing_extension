require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"
require "active_record/railtie"

Bundler.require(:default) if defined?(Bundler)

require "devise"
require "devise_password_sharing_extension"

module RailsApp
  class Application < Rails::Application
    config.filter_parameters << :password
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
  end
end
