class Product < ApplicationRecord
  belongs_to :business
  belongs_to :user, optional: true


  has_many :orders
  has_many :seller_Products
  
  has_many :admins_products, class_name: "AdminProduct"
  has_one_attached :image
end
