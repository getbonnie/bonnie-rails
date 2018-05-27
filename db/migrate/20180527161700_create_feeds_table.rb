#
class CreateFeedsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.uuid :uuid
      t.references :feedable, polymorphic: true
      t.integer :kind
      t.integer :status
      t.string :source
      t.timestamps
      t.index :status
    end
  end
end
