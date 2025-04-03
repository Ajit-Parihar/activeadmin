Rails.application.routes.draw do
  resources :sellers
  devise_for :users, controllers: {
     registrations: "users/registrations",
    sessions: "users/sessions"
  }

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "home#index"

  ActiveAdmin.routes(self)

  # namespace :admin, path: "admin_orders" do
  #   resources :orders, path: "admin_orders" # Changes /admin/orders → /dashboard_admin/custom_orders
  # end
  
end
