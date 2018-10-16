# !
class Notifications2 < ActiveRecord::Migration[5.2]
  def change
    add_index :notifications, :seen
    add_index :notifications, :clicked
    add_index :notifications, :sent
  end
end
