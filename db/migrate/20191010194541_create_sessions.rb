class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.text :type
      t.integer :price
      t.datetime :date
      t.integer :photographer_id
      t.integer :client_id
    end
  end
end
