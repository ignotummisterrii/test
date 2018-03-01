require 'rails_helper'

RSpec.describe WayPoint, type: :model do
	it { should belong_to(:vehicle) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:sent_at) }
  it { should validate_presence_of(:vehicle_identifier) }
end