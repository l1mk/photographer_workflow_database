class AddColumnToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :duration, :integer
  end
end
