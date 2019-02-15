#!
class ConvertHashtagToLower < ActiveRecord::Migration[5.2]
  def change
    Hashtag.all.each do |hashtag|
      hashtag.lower_tag = hashtag.tag.downcase
      hashtag.save
    end
  end
end
