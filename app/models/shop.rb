class Shop < ApplicationRecord
  has_many :opening_hours, dependent: :destroy
  has_one :category
  has_many :users_shops
  has_many :users, through: :users_shops
end
