class Adduidtofriendmodel < ActiveRecord::Migration
  def change
    add_column :friends, :uid, :string
  end
end
