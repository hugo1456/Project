class AddFiedsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
