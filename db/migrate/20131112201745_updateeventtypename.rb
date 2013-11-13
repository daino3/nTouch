class Updateeventtypename < ActiveRecord::Migration
  def change
    rename_column :events, :type, :eventtype
  end
end
