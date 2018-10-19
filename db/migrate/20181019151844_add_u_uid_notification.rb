# !
class AddUUidNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :uuid, :uuid, index: true, unique: true
  end
end
