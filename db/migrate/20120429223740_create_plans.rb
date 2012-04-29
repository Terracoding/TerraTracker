class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.string :description
      t.decimal :value
      t.string :duration
      t.integer :project_count
      t.integer :user_count

      t.timestamps
    end
  end
end
