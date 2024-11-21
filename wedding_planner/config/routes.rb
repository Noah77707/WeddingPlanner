Rails.application.routes.draw do
  resources :add_google_oauth_to_u_sers_for_calendars
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :calendars, only: [:calendars, :events, :new_event]

  # calendar routes
  get "/redirect", to: "calendars#redirect"
  get "/callback", to: "calendars#callback"
  get "/calendars", to: "calendars#calendars"
  get '/events/:calendar_id', to: 'example#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'example#new_event', as: 'new_event', calendar_id: /[^\/]+/

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
end
