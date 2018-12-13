# !
class AddUuidSub < ActiveRecord::Migration[5.2]
  def change
    add_column :notification_subscriptions, :uuid, :uuid, index: true, unique: true
    add_index :notification_subscriptions, %i[user_id pew_id], unique: true
  end
end
