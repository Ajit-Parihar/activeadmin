class AdminProduct < ApplicationRecord
  belongs_to :product
  belongs_to :admin, class_name: "User"
end
