#
class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.uuid :uuid
      t.string :name
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

    create_table :questions do |t|
      t.uuid :uuid
      t.bigint :topic_id
      t.bigint :category_id
      t.string :short
      t.string :long
      t.integer :status
      t.integer :reactions_count, default: 0, null: false
      t.timestamps
      t.index :topic_id
      t.index :category_id
      t.index :status
      t.index :uuid, unique: true
    end

    create_table :reactions do |t|
      t.uuid :uuid
      t.bigint :question_id
      t.bigint :user_id
      t.bigint :emotion_id
      t.integer :comments_count, default: 0, null: false
      t.integer :plays, default: 0, null: false
      t.integer :status
      t.timestamps
      t.index :emotion_id
      t.index :question_id
      t.index :user_id
      t.index :status
      t.index :uuid, unique: true
    end

    create_table :comments do |t|
      t.uuid :uuid
      t.bigint :reaction_id
      t.bigint :comment_id
      t.bigint :emotion_id
      t.bigint :user_id
      t.integer :status
      t.timestamps
      t.index :reaction_id
      t.index :comment_id
      t.index :emotion_id
      t.index :user_id
      t.index :status
      t.index :uuid, unique: true
    end

    create_table :topics do |t|
      t.uuid :uuid
      t.integer :questions_count, default: 0, null: false
      t.string :name
      t.string :content
      t.integer :status
      t.string :category_id
      t.timestamps
      t.index :status
      t.index :category_id
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
    end

    create_table :likes do |t|
      t.references :likable, polymorphic: true
      t.integer :how_much, default: 1, null: false
      t.bigint :user_id
      t.timestamps
    end

    create_table :flags do |t|
      t.references :flagable, polymorphic: true
      t.bigint :user_id
      t.integer :type
      t.integer :status
      t.timestamps
      t.index :user_id
      t.index :status
    end

    create_table :notifications do |t|
      t.integer :type
      t.bigint :user_id
      t.bigint :user_id_from
      t.string :message
      t.timestamps
      t.index :user_id
      t.index :user_id_from
    end

    create_table :categories do |t|
      t.string :name
      t.string :color
      t.integer :questions_count, default: 0, null: false
      t.integer :status
      t.timestamps
      t.index :status
    end

    add_foreign_key :devices, :users
    add_foreign_key :questions, :topics
    add_foreign_key :questions, :categories
    add_foreign_key :reactions, :questions
    add_foreign_key :reactions, :users
    add_foreign_key :reactions, :emotions
    add_foreign_key :comments, :reactions
    add_foreign_key :comments, :comments
    add_foreign_key :comments, :users
    add_foreign_key :comments, :emotions
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :user_id_from
    add_foreign_key :flags, :users
  end
end
