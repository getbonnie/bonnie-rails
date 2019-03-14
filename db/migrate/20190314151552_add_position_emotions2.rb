# !
class AddPositionEmotions2 < ActiveRecord::Migration[5.2]
  def change
    Emotion.order(:created_at).each.with_index(1) do |item, index|
      item.update_column :position, index
    end
  end
end
