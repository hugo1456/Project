class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :description
      t.boolean :status, default: false
      t.integer :collection_id

      t.timestamps
    end
    
    add_index :books, :name
    add_index :books, [:collection_id, :name], unique: true
  end
end
