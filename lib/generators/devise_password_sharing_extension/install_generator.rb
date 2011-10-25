module DevisePasswordSharingExtension
  module Generators # :nodoc:
    # Install Generator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Install the devise security extension"

      def add_configs
        inject_into_file "config/initializers/devise.rb", "\n  # ==> Password Sharing Extension\n" +
        "  # config.enable_banning = true\n" +
        "  # config.geoip_database = '/var/tmp/geoip.dat'\n" +
        "  # config.time_frame = 2.hour\n" +
        "  # config.number_of_cities = 10\n" +
        "\n", :before => /end[ |\n|]+\Z/
      end

      def copy_white_listed_ips
        copy_file("white_listed_ips.yml", "config/white_listed_ips.yml")
      end
    end
  end
end
