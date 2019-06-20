class CreateUsersShops < ActiveRecord::Migration[5.2]
  def change
    create_table :users_shops do |t|
      t.string :message
      t.integer :want_to_visit, default: 0
      t.boolean :_button_pushed, default: false
      t.integer :user_id
      t.integer :shop_id
      t.timestamps
    end
  end
end
