class AddHoursPerDayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hours_per_day, :integer
  end
end
