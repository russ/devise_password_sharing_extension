class LoginEvent < ActiveRecord::Base
  set_table_name 'login_events'

  validates_presence_of :ip_address, :latitude, :longitude
  validates_presence_of :city, :country_code, :region_name

  attr_accessible :ip_address, :latitude, :longitude
  attr_accessible :city, :country_code, :region_name

  def self.cities_in_the_last(time_frame = 2.hours)
    select('DISTINCT login_events.city').
    where('login_events.created_at >= ?', time_frame.ago)
  end
end
