class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references  :company
      t.string      :name
      t.string      :status
      t.boolean     :archived, :default => false
      t.timestamps
    end
  end
end
