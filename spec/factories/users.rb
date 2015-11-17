FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "First#{n}" }
    sequence(:last_name) { |n| "Last#{n}" }
    sequence(:email) { "#{first_name}.#{last_name}@example.com" }
    password 'z1x2c3v4'
    password_confirmation 'z1x2c3v4'
  end
end