class AddFitbitconfiguredToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fitbitconfigured, :boolean
  end
end
