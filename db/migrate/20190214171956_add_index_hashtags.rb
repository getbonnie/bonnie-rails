#!
class AddIndexHashtags < ActiveRecord::Migration[5.2]
  def change
    add_index :hashtags, :tag
    add_index :hashtags, :created_at
  end
end
