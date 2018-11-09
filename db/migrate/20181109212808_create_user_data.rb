class CreateUserData < ActiveRecord::Migration[5.2]
  def change
    create_table :user_data do |t|
      t.integer :index,     null: false, default: ""
      t.string :emailid,     null: false, default: ""
      t.jsonb :content

      t.timestamps
    end
    add_index :user_data, :index,    unique: true
  end
end
