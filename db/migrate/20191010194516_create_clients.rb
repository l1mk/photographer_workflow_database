class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :firstname
      t.text :lastname
      t.text :email 
      t.text :status
    end
  end
end
