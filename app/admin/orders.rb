ActiveAdmin.register Order do


    controller do
      def scoped_collection
        if current_user.admin?
          Order.all
          Order.where(id: Order.select("MIN(id)").group(:product_id))
        else
           Order.where(admin_id: current_user)
           Order.where(id: Order.select("MIN(id)").group(:product_id))
        end
      end
    end
  
  index do
     paramsbusiness = params[:business_id]

    selectable_column
    column "Product Name" do |order|
     
       product = Product.find(order.product_id)
       business = product.business_id       
         if paramsbusiness.to_i == business
              Product.find(order.product_id).name
         else
          if paramsbusiness == nil&& current_user&.admin?
            if order.admin_id == current_user.id
              Product.find(order.product_id).name
            end
          end
         end
      end
       column "Product Price" do |order|
        product = Product.find(order.product_id)
        business = product.business_id
          if paramsbusiness.to_i == business
              Product.find(order.product_id).price
            else 
              if paramsbusiness == nil && current_user&.admin?
                if order.admin_id == current_user.id
                  Product.find(order.product_id).price
                end
              end
            end
          end
     actions
  end

  show do
  # user = User.find(order.user_id) 
  all_orders = Order.where(admin_id: current_user.id) 

  panel "Other Users Who Ordered This Product" do
    table_for all_orders do
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
