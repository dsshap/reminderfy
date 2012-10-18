# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    fname 'John'
    lname 'Doe'
    email 'jd@example.com'
    password 'password'
    password_confirmation 'password'
    establishment_name 'test office'
  end
end

