class CreateAdminProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :admin_products do |t|
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
