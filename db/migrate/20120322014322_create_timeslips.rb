class CreateTimeslips < ActiveRecord::Migration
  def change
    create_table :timeslips do |t|

      t.timestamps
    end
  end
end
