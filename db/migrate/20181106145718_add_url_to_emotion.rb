# !
class AddUrlToEmotion < ActiveRecord::Migration[5.2]
  def change
    add_column :emotions, :url, :string
  end
end
