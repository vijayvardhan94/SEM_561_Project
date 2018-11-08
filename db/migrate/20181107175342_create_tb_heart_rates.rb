class CreateTbHeartRates < ActiveRecord::Migration[5.2]
  def change
    create_table :tb_heart_rates do |t|
      t.integer :index,     null: false, default: ""
      t.string :emailid,    null: false, default: ""
      t.datetime :date
      t.integer :dailyHeartRate
      t.integer :hourlyHeartRate
      t.timestamp :timestamp,  null: false, default: ""

      t.timestamps
    end
  
    add_index :tb_heart_rates, :index,    unique: true
  end
end
