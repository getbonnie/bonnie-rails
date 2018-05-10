#
class CreateTableClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications do |t|
      t.string :name
      t.integer :status
      t.timestamps
      t.index :status
    end

    add_column :questions, :classification_id, :bigint, index: true
    add_foreign_key :questions, :classifications
  end
end
