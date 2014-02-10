class CreateReminderReceipts < ActiveRecord::Migration
  def change
    create_table :reminder_receipts do |t|
      t.integer :event_id
      t.boolean :status
      t.boolean :email, default: false
      t.boolean :text, defualt: false
      t.timestamps
    end
  end
end
