#!
class CreateHashtag < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.bigint :pew_id
      t.string :tag, limit: 40
      t.timestamps
    end

    Pew.all.each do |pew|
      Hashtag.create(
        pew: pew,
        tag: pew.hashtag
      )
    end

    rename_column :pews, :hashtag, :inline_hashtags
  end
end
