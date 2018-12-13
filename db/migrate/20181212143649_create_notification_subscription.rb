#!
class CreateNotificationSubscription < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_subscriptions do |t|
      t.bigint :pew_id
      t.bigint :user_id
      t.timestamps
    end
  end
end
