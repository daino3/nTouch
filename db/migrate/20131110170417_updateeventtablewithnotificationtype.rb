class Updateeventtablewithnotificationtype < ActiveRecord::Migration
  def change
    add_column :events, :notificationtype, :string, default: "both"
  end
end
