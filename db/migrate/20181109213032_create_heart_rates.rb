class CreateHeartRates < ActiveRecord::Migration[5.2]
  def change
    create_table :heart_rates do |t|
      t.integer :index,     null: false, default: ""
      t.string :emailid,     null: false, default: ""
      t.jsonb :content

      t.timestamps
    end
    add_index :heart_rates, :index,    unique: true
  end
end
