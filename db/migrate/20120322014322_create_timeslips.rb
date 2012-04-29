class CreateTimeslips < ActiveRecord::Migration
  def change
    create_table :timeslips do |t|
      t.references  :project
      t.references  :task
      t.references  :user
      t.decimal     :hours, :precision => 10, :scale => 2
      t.string      :comment
      t.date        :date
      t.timestamps
    end
  end
end
