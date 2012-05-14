FactoryGirl.define do
  factory :user do
    company
    company_admin   false
    firstname       'Test'
    lastname        'User'
    email           'example@example.com'
    password        'please'
    password_confirmation 'please'
  end

  factory :plan do
    title               "Free"
    description         "Free plan"
    value               0
    duration            "MONTHLY"
    project_count       100
    user_count          100
  end

  factory :company do
    name                "company name"
    plan                FactoryGirl.create(:plan)
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
    date      Date.today
  end

  factory :bill do
    user
    company
    reference_id  "0"
    bill_date     Date.today
    due_date      Date.today
    value         "1.00"
    comment       "test comment"
  end

  factory :subscription do
    company
    resource_id   10
    resource_type "subscription"
    subscribed    1
    merchant_id   11
  end
end