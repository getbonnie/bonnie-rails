#
class AddColumnTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :tag, :string
  end
end
