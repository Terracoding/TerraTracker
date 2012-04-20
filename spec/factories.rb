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

  factory :project do
    company
    name      "project name"
  end

  factory :task do
    project
    name      "task name"
  end

  factory :project_user do
    project
    user
  end

  factory :timeslip do
    project
    task
    user
    hours     1.0
    comment   "test comment"
  end

  factory :bill do
    user
    company
    reference_id  "0"
    bill_date     Date.new
    due_date      Date.new
    value         "1.00"
    comment       "test comment"
  end
end