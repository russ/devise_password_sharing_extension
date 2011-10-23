module Devise
  module Models
    module PasswordSharing
      extend ActiveSupport::Concern

      module ClassMethods
        Devise::Models.config(self, :geoip_database)
        Devise::Models.config(self, :time_frame)
        Devise::Models.config(self, :number_of_cities)
      end

      included do
        has_many :login_events, :class_name => 'DevisePasswordSharingExtension::LoginEvent'
      end

      def create_login_event!(request)
        unless request.remote_ip == '127.0.0.1'
          database = GeoIP.new(self.class.geoip_database)
          geo = database.city(request.remote_ip)

          login_events.create!(
            :ip_address => request.remote_ip,
            :latitude => geo.latitude,
            :longitude => geo.longitude,
            :city => geo.city_name,
            :country_code => geo.country_code2,
            :region_name => geo.region_name)
        end
      end

      def ban_for_password_sharing!
        self.banned_for_password_sharing_at = Time.now
        save(:validate => false)
      end

      def password_sharing?
        login_events.grouped_by_city(self.class.time_frame).any? do |g|
          g.count >= self.class.number_of_cities
        end
      end
    end
  end
end
