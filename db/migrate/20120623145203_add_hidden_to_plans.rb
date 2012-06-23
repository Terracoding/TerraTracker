class AddHiddenToPlans < ActiveRecord::Migration
  def up
    change_table(:plans) do |t|
      t.boolean :hidden, :default => false
    end
  end

  def down
    change_table(:plans) do |t|
      t.remove :hidden
    end
  end
end
