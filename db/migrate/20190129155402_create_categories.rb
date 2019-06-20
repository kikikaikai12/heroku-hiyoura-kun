class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :shop_id
      t.string :feature_1
      t.string :feature_2
      t.timestamps
    end
  end
end
