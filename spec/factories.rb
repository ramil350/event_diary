FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end

  factory :event do
    title { Faker::Lorem.sentence }
    starts_on { Faker::Date.forward(30) }
    recurring false
    repeats nil
    user
  end
end