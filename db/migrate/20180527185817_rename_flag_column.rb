#
class RenameFlagColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :flags, :type, :kind
  end
end
