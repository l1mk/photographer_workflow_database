class TypeReplaceByName < ActiveRecord::Migration
  def change
    rename_column :sessions, :type, :name
  end
end
