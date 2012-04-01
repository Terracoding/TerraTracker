class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references  :user
      t.string      :last_4_digits
      t.string      :stripe_id
      t.boolean     :subscribed, :default => false
      t.integer     :plan
      t.timestamps
    end
  end
end
