class Addtextandemailbooleantoeventmodel < ActiveRecord::Migration
  def change
    add_column :events, :text, :boolean, default: false
    add_column :events, :email, :boolean, default: false
  end
end
