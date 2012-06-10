ActiveAdmin.register User do
  filter :email
  filter :company_admin, :as => :check_boxes
  filter :owns_company, :as => :check_boxes
  filter :sub_account, :as => :check_boxes
  filter :company
  
  index do
    column :id
    column :email
    column :firstname
    column :lastname
    column :company_admin
    column :owns_company
    column :sub_account
    column :company_id
    default_actions
  end
end
