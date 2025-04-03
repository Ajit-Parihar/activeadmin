class AddForeignKeyToAdminProducts < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :admin_products, :users, column: :admin_id
  end
end
