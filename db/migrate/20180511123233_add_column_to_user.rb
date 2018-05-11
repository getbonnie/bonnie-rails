#
class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_connected_at, :datetime
  end
end
