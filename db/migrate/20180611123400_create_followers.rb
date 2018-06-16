#
class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.bigint :user_id
      t.bigint :followed_id
      t.timestamps
    end
  end
end
