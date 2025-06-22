Rails.application.routes.draw do
  # Custom login/logout routes
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Dashboards (fixed controller name)
  get "/receptionist/dashboard", to: "dashboards#receptionist", as: :receptionist_dashboard
  get "/doctor/dashboard",       to: "dashboards#doctor",       as: :doctor_dashboard

  # Root path goes to login page
  root "sessions#new"

  # Health check (default Rails route)
  get "up" => "rails/health#show", as: :rails_health_check
end
