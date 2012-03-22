FactoryGirl.define do
  factory :user do
    firstname 'Test'
    lastname 'User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
  end
  
  factory :company do
    user
    name                "company name"
    registration_number "0001"
  end
end