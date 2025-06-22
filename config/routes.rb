Rails.application.routes.draw do
  get "dashboard/receptionist"
  get "dashboard/doctor"
  # Custom login/logout routes
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Dashboards
  get "/receptionist_dashboard", to: "dashboard#receptionist"
  get "/doctor_dashboard",       to: "dashboard#doctor"

  # Root path goes to login page for now
  root "sessions#new"

  # Health check (default Rails route)
  get "up" => "rails/health#show", as: :rails_health_check
end
