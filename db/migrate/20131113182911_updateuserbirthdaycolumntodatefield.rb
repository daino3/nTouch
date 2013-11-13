class Updateuserbirthdaycolumntodatefield < ActiveRecord::Migration
  def change
    remove_column :users, :birthday
    add_column :users, :birthday, :date 
  end
end
