# !
class AddModeNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :mode, :integer
  end
end
