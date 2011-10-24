ENV["RAILS_ENV"] = "test"

$:.unshift File.dirname(__FILE__)

require 'rails_app/config/environment'
require 'orm/active_record'
require 'rails/test_help'
require 'rspec'
require 'shoulda'
require 'capybara/rails'
require 'capybara/rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    User.destroy_all
    DevisePasswordSharingExtension::LoginEvent.destroy_all
  end
end
