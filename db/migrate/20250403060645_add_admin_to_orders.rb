class AddAdminToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :admin_id, :integer
  end
end
