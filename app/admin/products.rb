ActiveAdmin.register Product do



  remove_filter :image_attachment, :image_blob

  permit_params :name, :price, :brand_name, :image, :business_id

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :price
      f.input :brand_name
      f.input :image, as: :file
      f.input :business_id, as: :radio, collection: Business.pluck(:category, :id), label: "Product Category"
        end
    f.actions
  end

  controller do
    def scoped_collection
      if current_user.admin?
        Product.all    
      else
        product_ids = AdminProduct.where(admin_id: current_user.id).pluck(:product_id)
        Product.where(id: product_ids)      end
    end
  end

  index do 
     selectable_column 
      id_column
      column :name
      column :brand_name
      column :price
      column :image do |product|
        if product.image.attached?
          link_to image_tag(product.image, alt: product.name, style: 'max-width: 300px;'), admin_product_path(product)
        else
          "No image available"
        end
      end
   end
   
  show do 
     attributes_table do 
      row :image do |product|
             if product.image.attached?
                image_tag product.image, alt: product.name, style: 'max-width: 300px;' 
                 else
                "No image available"
              end
            end
       row :price
       row :name
       row :brand_name
      end
      orders = Order.where(product_id: product.id) 
      sellers = SellerProduct.where(product_id: product.id)
            panel "buyers" do
               table_for orders do
                  column "User" do |order|
               order.user.email
            end
            column "Ordered At" do |order|
              order.created_at.strftime("%B %d, %Y %H:%M")
            end
            column "Seller" do |order|
              order.seller.email
           end
          end 
      end
   end
end