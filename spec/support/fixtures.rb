class Request < Struct.new(:remote_ip); end

def mock_geo_database(attributes = {})
  attributes[:latitude] ||= 0.0
  attributes[:longitude] ||=  0.0
  attributes[:city] ||= 'City'
  attributes[:country_code] ||= 'USA'
  attributes[:region_name] ||= 'NV'

  geo_database_mock, geo_mock = mock('GeoIP'), mock('Geo')

  geo_mock.stub(:latitude).and_return(attributes[:latitude])
  geo_mock.stub(:longitude).and_return(attributes[:longitude])
  geo_mock.stub(:city_name).and_return(attributes[:city])
  geo_mock.stub(:country_code2).and_return(attributes[:country_code])
  geo_mock.stub(:region_name).and_return(attributes[:region_name])

  geo_database_mock.stub(:city).and_return(geo_mock)
  GeoIP.stub(:new).and_return(geo_database_mock)
end

def request_fixture(remote_ip = '192.168.1.1')
  Request.new(remote_ip)
end

def user_fixture(attributes = {})
  User.create!(
    { :username => 'test',
      :email => 'test@test.com',
      :password => 'password',
      :password_confirmation => 'password' }.merge(attributes))
end
