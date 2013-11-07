class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.integer :friend_id
    	t.string :title
    	t.string :description
    	t.date :date

    	t.timestamps
    end
  end
end
