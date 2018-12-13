# !
class AddFollowComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :notify, :boolean, default: true
    add_column :pews, :notify, :boolean, default: true
  end
end
