class CreateDeveloperApplications < ActiveRecord::Migration
  def change
    create_table :developer_applications do |t|
      t.references  :user
      t.string      :name
      t.string      :url
      t.text        :description
      t.string      :api_key
      t.string      :secret_key
      t.boolean     :active, :default => true
      t.timestamps
    end
  end
end
