class AddRatingSessions < ActiveRecord::Migration
  def change
      add_column :sessions, :rating, :integer
  end
end
