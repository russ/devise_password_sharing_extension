require 'spec_helper'

describe LoginEvent do
  it { should validate_presence_of(:ip_address) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country_code) }
  it { should validate_presence_of(:region_name) }
end
