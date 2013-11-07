class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
    	t.integer :user_id
    	t.string :photo_name


    	t.timestamps
    end
  end
end
