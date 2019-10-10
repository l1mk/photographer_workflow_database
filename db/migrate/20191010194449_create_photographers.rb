class CreatePhotographers < ActiveRecord::Migration
  def change
    create_table :photographers do |t|
      t.text :firstname
      t.text :lastname
      t.text :username
      t.text :email
      t.text :password_digest
    end
  end
end
