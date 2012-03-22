class CreateCompanyUsers < ActiveRecord::Migration
  def change
    create_table :company_users do |t|

      t.timestamps
    end
  end
end
