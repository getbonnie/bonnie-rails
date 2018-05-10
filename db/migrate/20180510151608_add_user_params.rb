#
class AddUserParams < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string, index: true
    add_column :users, :ref_firebase, :string, index: true, unique: true
    add_column :users, :notify_comments, :boolean, index: true
    add_column :users, :notify_likes, :boolean, index: true
    add_column :users, :notify_features, :boolean, index: true
    add_column :users, :notify_ads, :boolean, index: true
  end
end
