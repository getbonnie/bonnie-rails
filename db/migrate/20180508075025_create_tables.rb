#
class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.uuid :uuid
      t.string :name
      t.date :birthdate
      t.string :city
      t.decimal :latitude, precision: 10, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.string :phone
      t.string :ref_firebase
      t.boolean :notify_comments
      t.boolean :notify_likes
      t.boolean :notify_features
      t.boolean :notify_ads
      t.datetime :last_connected_at
      t.integer :status
      t.timestamps
      t.index :status
      t.index :uuid, unique: true
    end

    create_table :devices do |t|
      t.bigint :user_id
      t.string :reference
      t.timestamps
      t.index :user_id
    end

    create_table :pews do |t|
      t.uuid :uuid
      t.bigint :user_id
      t.string :hashtag
      t.bigint :emotion_id
      t.integer :status
      t.integer :duration
      t.integer :comments_count, default: 0, null: false
      t.integer :plays_count, default: 0, null: false
      t.integer :likes_count, default: 0, null: false
      t.timestamps
      t.index %i[hashtag status created_at]
      t.index :status
      t.index :user_id
      t.index :emotion_id
      t.index :uuid, unique: true
    end

    create_table :comments do |t|
      t.uuid :uuid
      t.bigint :pew_id
      t.bigint :user_id
      t.bigint :comment_id
      t.bigint :emotion_id
      t.integer :status
      t.integer :duration
      t.integer :plays_count, default: 0, null: false
      t.integer :likes_count, default: 0, null: false
      t.timestamps
      t.index %i[pew_id status created_at]
      t.index :status
      t.index :pew_id
      t.index :user_id
      t.index :emotion_id
      t.index :uuid, unique: true
    end

    create_table :emotions do |t|
      t.string :name
      t.integer :status
      t.timestamps
      t.index :status
    end

    create_table :plays do |t|
      t.references :playable, polymorphic: true
      t.bigint :user_id
      t.timestamps
      t.index :user_id
    end

    create_table :likes do |t|
      t.references :likable, polymorphic: true
      t.integer :how_much, default: 1, null: false
      t.bigint :user_id
      t.timestamps
      t.index :user_id
    end

    create_table :flags do |t|
      t.references :flagable, polymorphic: true
      t.bigint :user_id
      t.integer :kind
      t.integer :status
      t.timestamps
      t.index :user_id
      t.index :status
    end

    create_table :notifications do |t|
      t.integer :kind
      t.references :notificationable, polymorphic: true, index: { name: :notificationable }
      t.bigint :user_id
      t.bigint :from_id
      t.string :message
      t.timestamps
      t.index :user_id
      t.index :from_id
    end
  end
end
