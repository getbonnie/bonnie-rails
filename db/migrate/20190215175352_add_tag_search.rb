#!
class AddTagSearch < ActiveRecord::Migration[5.2]
  def change
    add_column :hashtags, :lower_tag, :string, index: true
  end
end
