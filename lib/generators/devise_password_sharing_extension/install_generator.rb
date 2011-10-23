module DevisePasswordSharingExtension
  module Generators # :nodoc:
    # Install Generator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Install the devise security extension"

      def add_configs
        inject_into_file "config/initializers/devise.rb", "\n  # ==> Password Sharing Extension" +
        "  # config.geoip_database = /var/tmp/geoip.dat\n" +
        "  # config.sharing_time_frame = 1.hour\n" +
        "  # config.number_of_cities = 2\n" +
        "\n", :before => /end[ |\n|]+\Z/
      end
    end
  end
end
