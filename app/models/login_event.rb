class LoginEvent < ActiveRecord::Base
  self.table_name = 'login_events'

  validates :ip_address, presence: true

  # attr_accessible :ip_address, :latitude, :longitude
  # attr_accessible :city, :country_code, :region_name

  def self.cities_in_the_last(time_frame = 2.hours)
    select('DISTINCT login_events.city').
    where('login_events.city IS NOT NULL').
    where('login_events.created_at >= ?', time_frame.ago)
  end
end
