class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
    	t.integer :user_id
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.string :birthday
        t.string :phone_number
    	t.string :photo

    	t.timestamps
    end
  end
end
