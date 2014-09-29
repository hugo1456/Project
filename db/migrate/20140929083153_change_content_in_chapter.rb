class ChangeContentInChapter < ActiveRecord::Migration
  def change
    change_column :chapters, :content, :binary, default: "Add content here"
  end
end
