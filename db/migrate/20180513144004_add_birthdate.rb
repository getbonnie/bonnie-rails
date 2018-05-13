#
class AddBirthdate < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birthdate, :date
    add_column :users, :city, :string
    add_column :users, :latitude, :decimal, precision: 10, scale: 8
    add_column :users, :longitude, :decimal, precision: 11, scale: 8
    add_column :topics, :published_at, :datetime
    add_column :reactions, :length, :integer
    add_column :comments, :length, :integer
  end
end
