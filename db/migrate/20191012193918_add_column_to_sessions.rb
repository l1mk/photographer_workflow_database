class AddColumnToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :duration, :integer
    add_column :sessions, :rating, :integer
  end
end
