
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    if current_user
      div class: "admin-info" do
        para "Logged in as: #{current_user.email}"
      end
    end

    total_users = User.count
    total_users-=1
    total_admins = User.where(role: 'admin').count
    total_sellers = User.where(role: 'seller').count
    total_regular_users = User.where(role: 'user').count

    ratio_admin = total_admins.to_f / total_users
    ratio_seller = total_sellers.to_f / total_users
    ratio_user = total_regular_users.to_f / total_users

    div class: 'dashboard-container ' do
      panel "User Role Ratios" do
        para "Total Users: #{total_users}", class: 'total'
        para "Admins: #{total_admins} (#{(ratio_admin * 100).round(2)}%)"
        div class: 'percentage admins' do
          para "#{(ratio_admin * 100).round(2)}%"
        end

        para "Sellers: #{total_sellers} (#{(ratio_seller * 100).round(2)}%)"
        div class: 'percentage sellers' do
          para "#{(ratio_seller * 100).round(2)}%"
        end

        para "Regular Users: #{total_regular_users} (#{(ratio_user * 100).round(2)}%)"
        div class: 'percentage regular-users' do
          para "#{(ratio_user * 100).round(2)}%"
        end
      end
    end

    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
     end
    end
   end


