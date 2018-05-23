#
class AddKindToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :kind, :integer
  end
end
