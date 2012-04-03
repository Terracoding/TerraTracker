class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references  :user
      t.integer     :plan_id
      t.string      :resource_id
      t.string      :signature
      t.string      :resource_type
      t.string      :resource_uri
      t.boolean     :subscribed, :default => false
      t.string      :merchant_id
      t.string      :subscription_acount
      t.string      :resource_user_id
      t.timestamps
    end
  end
end
