#!
class Importcontacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.uuid :uuid
      t.bigint :user_id
      t.string :name
      t.string :phone_number
      t.timestamps
      t.index :uuid
      t.index [:user_id, :phone_number], unique: true
    end
  end
end
