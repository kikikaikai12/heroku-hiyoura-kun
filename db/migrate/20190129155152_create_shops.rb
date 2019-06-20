class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :genre
      t.string :shop_name
      t.float :tabelog_review
      t.float :google_review
      t.integer :seat
      t.string :table
      t.string :holiday
      t.integer :reference_price
      t.string :reference_menu
      t.string :image_file_name
      t.string :reserve
      t.string :telephone_number
      t.string :latitude
      t.string :longnitude
      t.string :google_map_url
      t.string :tabelog_url
      t.string :official_url
      t.timestamps
    end
  end
end
