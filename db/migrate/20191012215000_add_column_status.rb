class AddColumnStatus < ActiveRecord::Migration
  def change
      add_column :sessions, :status, :text
  end
end
