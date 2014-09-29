class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :content
      t.boolean :status, default: false
      t.integer :book_id
      t.string :slug

      t.timestamps
    end
    
    add_index :chapters, :name
    add_index :chapters, [:book_id, :name], unique: true
    add_index :chapters, :slug
  end
end
