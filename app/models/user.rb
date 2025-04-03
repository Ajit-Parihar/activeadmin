

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :products
  has_many :businesses
  has_many :orders

  has_one :admin_product, foreign_key: :admin_id, dependent: :destroy # One-to-One
  

  enum role: { user: 0, seller: 1, admin: 2}

  def timeout_in
    1.hours
  end

  def admin?
    role == "admin"
  end
  
end
