#
class ChangeTypeCategoryId < ActiveRecord::Migration[5.2]
  def change
    change_column :topics, :category_id, :bigint, using: 'category_id::bigint'
  end
end
