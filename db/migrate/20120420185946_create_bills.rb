class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references  :user
      t.references  :company
      t.string      :reference_id
      t.date        :bill_date, :default => DateTime.now
      t.date        :due_date, :default => DateTime.now
      t.decimal     :value, :precision => 10, :scale => 2
      t.text        :comment
      t.boolean     :paid
      t.timestamps
    end
  end
end
