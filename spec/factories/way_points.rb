FactoryBot.define do
  factory :way_point do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    sent_at { Faker::Date.between(2.days.ago, Date.today) } 
  end
end