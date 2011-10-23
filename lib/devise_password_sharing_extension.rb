require 'geoip'
require 'devise'
require 'devise_password_sharing_extension/schema'
require 'devise_password_sharing_extension/rails'

module Devise
  mattr_accessor :geoip_database
  @@geoip_database = '/var/tmp/geoip.dat'

  mattr_accessor :time_frame
  @@time_frame = 1.hour

  mattr_accessor :number_of_cities
  @@number_of_cities = 2
end

Devise.add_module(:password_sharing, :model => 'devise_password_sharing_extension/models/password_sharing')
