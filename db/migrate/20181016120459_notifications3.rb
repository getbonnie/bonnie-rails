# !
class Notifications3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :seen
    remove_column :notifications, :sent
    remove_column :notifications, :clicked
    add_column :notifications, :seen, :bool, default: false, null: false, index: true
    add_column :notifications, :sent, :bool, default: false, null: false, index: true
    add_column :notifications, :clicked, :bool, default: false, null: false, index: true
  end
end
