# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach("#{Rails.root.to_s}/csv/1_shop.csv", encoding: 'UTF-8', headers: true) do |row|
    shop = Shop.new(
        genre: row[0],
        shop_name: row[1],
        tabelog_review: row[2],
        google_review: row[3],
        seat: row[4],
        table: row[5],
        holiday: row[6],
        reference_price: row[7],
        reference_menu: row[8],
        image_file_name: row[9],
        reserve: row[10],
        telephone_number: row[11],
        latitude: row[12],
        longnitude: row[13],
        google_map_url: row[14],
        tabelog_url: row[15],
        official_url: row[16],
    )
    shop.save
end
        
CSV.foreach("#{Rails.root.to_s}/csv/2_time.csv", encoding: 'UTF-8', headers: true) do |row|
opening_hour = OpeningHour.new(
    shop_id: row[1],
    day_of_the_week: row[2],
    open_time_1: row[3],
    close_time_1: row[4],
    open_time_2: row[5],
    close_time_2: row[6]
    )
    opening_hour.save
end
        
CSV.foreach("#{Rails.root.to_s}/csv/3_category.csv", encoding: 'UTF-8', headers: true) do |row|
    category = Category.new(
        shop_id: row[1],
        feature_1: row[2],
        feature_2: row[3],
    )
    category.save
end