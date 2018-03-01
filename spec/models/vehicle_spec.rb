require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should have_many(:way_points) }
  it { should validate_presence_of(:identifier) }
end