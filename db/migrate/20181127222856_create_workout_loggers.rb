class CreateWorkoutLoggers < ActiveRecord::Migration[5.2]
  def change
    create_table :workout_loggers do |t|
      t.datetime :date
      t.float :height
      t.float :weight
      t.integer :steps
      t.float :activitycalories
      t.datetime :sleepstarttime
      t.datetime :sleependtime

      t.timestamps
    end
  end
end
