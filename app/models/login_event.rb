module DevisePasswordSharingExtension
  class LoginEvent < ActiveRecord::Base
    set_table_name 'login_events'

    validates_presence_of :ip_address, :latitude, :longitude
    validates_presence_of :city, :country_code, :region_name

    attr_accessible :ip_address, :latitude, :longitude
    attr_accessible :city, :country_code, :region_name

    def self.grouped_by_city(time_frame = 1.hour)
      select('COUNT(*) AS count, login_events.city').
      where('login_events.created_at >= ?', Time.now - time_frame).
      group('login_events.city')
    end
  end
end
