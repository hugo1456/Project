class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.string :description
      t.boolean :status, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :collections, :name
    add_index :collections, [:user_id, :name], unique: true
  end
end
