class UpdateClientsTable < ActiveRecord::Migration
  def change
    remove_column :clients, :status
    remove_column :clients, :rating
  end
end
