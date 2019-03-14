# !
class AddPositionEmotions < ActiveRecord::Migration[5.2]
  def change
    add_column :emotions, :position, :integer
  end
end
