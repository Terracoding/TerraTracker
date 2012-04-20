class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references  :user
      t.references  :company
      t.string      :reference_id
      t.date        :bill_date
      t.date        :due_date
      t.decimal     :value, :precision => 10, :scale => 2
      t.text        :comment
      t.timestamps
    end
  end
end
