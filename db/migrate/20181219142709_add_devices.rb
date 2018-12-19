#!
class AddDevices < ActiveRecord::Migration[5.2]
  def change
    drop_table :devices

    create_table :devices do |t|
      t.bigint :user_id
      t.string :reference, limit: 40
      t.string :token
      t.timestamps
      t.index :user_id
      t.index :reference, unique: true
    end
  end
end
