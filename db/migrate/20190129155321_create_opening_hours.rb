class CreateOpeningHours < ActiveRecord::Migration[5.2]
  def change
    create_table :opening_hours do |t|
      t.integer :shop_id
      t.string :day_of_the_week
      t.string :open_time_1
      t.string :close_time_1
      t.string :open_time_2
      t.string :close_time_2
      t.timestamps
    end
  end
end
