#
class RemoveCategoryFromQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :category_id
  end
end
