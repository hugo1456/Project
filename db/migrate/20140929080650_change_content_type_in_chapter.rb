class ChangeContentTypeInChapter < ActiveRecord::Migration
  def change
    change_column :chapters, :content, :binary
  end
end
