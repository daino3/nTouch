class Removedtextandemailfieldsfromreminderreceiptmodel < ActiveRecord::Migration
  def change
    remove_column :reminder_receipts, :text
    remove_column :reminder_receipts, :email
  end
end
