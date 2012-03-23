FactoryGirl.define do
  factory :user do
    company
    firstname 'Test'
    lastname  'User'
    email     'example@example.com'
    password  'please'
    password_confirmation 'please'
  end
  
  factory :company do
    name                "company name"
    registration_number "0001"
  end
end