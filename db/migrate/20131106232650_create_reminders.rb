class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
    	t.integer :event_id
    	t.boolean :email, default: false
    	t.boolean :text, defualt: false
    	t.datetime :notification_date
    	t.timestamps
    end
  end
end
