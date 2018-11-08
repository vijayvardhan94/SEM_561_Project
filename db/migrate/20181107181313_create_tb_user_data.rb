class CreateTbUserData < ActiveRecord::Migration[5.2]
  def change
    create_table :tb_user_data do |t|
      t.integer :index,     null: false, default: ""
      t.string :emailid,     null: false, default: ""
      t.string :fullName
      t.integer :age
      t.string :avatar
      t.string :avatar150
      t.string :avatar640
      t.string :country
      t.string :gender
      t.float :height
      t.float :weight
      t.string :weightUnit
      t.integer :steps
      t.integer :lightlyActiveMinutes
      t.integer :fairlyActiveMinutes
      t.integer :veryActiveMinutes
      t.integer :activityCalories
      t.datetime :sleepStartTime
      t.datetime :sleepEndTime
      t.integer :minutesAsleep
      t.integer :minutesAwake
      t.timestamp :timestamp,     null: false, default: ""
      t.boolean :flag_manual

      t.timestamps
    end
    add_index :tb_user_data, :index,    unique: true
  end
end
