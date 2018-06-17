#
class AddIndexUniqueUsername < ActiveRecord::Migration[5.2]
  def change
    add_index :users,
              'lower(name) varchar_pattern_ops',
              name: "index_users_on_name_unique",
              unique: true
  end
end
