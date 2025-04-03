class AddColumnNameToAdminProduct < ActiveRecord::Migration[7.2]
  def change
    add_column :admin_products, :admin_id, :integer
  end
end
