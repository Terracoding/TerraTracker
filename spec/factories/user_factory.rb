FactoryGirl.define do
  factory :user do
    firstname 'Test'
    lastname 'User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end