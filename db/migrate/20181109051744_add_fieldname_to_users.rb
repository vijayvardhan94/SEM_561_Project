class AddFieldnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fitbitkey, :string
  end
end
