# !
class Notifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :message, :string
    add_column :notifications, :sent, :bool
    add_column :notifications, :seen, :bool
    add_column :notifications, :clicked, :bool
  end
end
