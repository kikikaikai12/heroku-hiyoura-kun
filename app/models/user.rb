class User < ApplicationRecord
  has_many :users_shops
  has_many :shops, through: :users_shops
end
