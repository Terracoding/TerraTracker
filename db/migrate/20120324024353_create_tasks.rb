class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references  :project
      t.string      :name
      t.boolean     :billable
      t.decimal     :rate, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
