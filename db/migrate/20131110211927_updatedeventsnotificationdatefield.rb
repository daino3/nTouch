class Updatedeventsnotificationdatefield < ActiveRecord::Migration
  def change
    change_column :events, :notification_date, :datetime
  end
end
