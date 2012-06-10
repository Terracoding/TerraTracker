ActiveAdmin.register Company do
  menu :parent => "TimeTracker Data"

  index do
    column :id
    column :name
    column :registration_number
    default_actions
  end
end
