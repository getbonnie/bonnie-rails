# !
class AddBase64 < ActiveRecord::Migration[5.2]
  def change
    add_column :emotions, :emoji, :string
  end
end
