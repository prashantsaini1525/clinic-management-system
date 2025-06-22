Rails.application.routes.draw do
  # RESTful patient routes
  resources :patients

  # Custom login/logout routes
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Dashboards
  get "/receptionist/dashboard", to: "dashboards#receptionist", as: :receptionist_dashboard
  get "/doctor/dashboard",       to: "dashboards#doctor",       as: :doctor_dashboard

  # Root path (login page)
  root "sessions#new"

  # Health check (default Rails route)
  get "up" => "rails/health#show", as: :rails_health_check
end
