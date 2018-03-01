FactoryBot.define do
  factory :vehicle do
    identifier { Faker::Vehicle.vin }
  end
end