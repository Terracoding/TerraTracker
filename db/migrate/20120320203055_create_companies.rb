class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.references  :user
      t.string      :name
      t.string      :registration_number
      t.timestamps
    end
  end
end
