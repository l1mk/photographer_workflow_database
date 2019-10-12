class AddColumnLocation < ActiveRecord::Migration
  def change
    add_column :sessions, :location, :text
  end
end
