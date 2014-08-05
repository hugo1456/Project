class AddLanguageToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :language, :int, default: 1
  end
  add_index :collections, [:user_id, :created_at]
end
