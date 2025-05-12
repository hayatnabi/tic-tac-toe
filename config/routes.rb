Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get "/game", to: "games#new", as: :new_game
  # post "/game/move", to: "games#update", as: :make_move
  # post "/game/reset", to: "games#create", as: :reset_game

  resources :games, only: [:new, :create]

  # post "game/make_move", to: "game#make_move", as: "make_move_game"
  # post "game/restart", to: "game#restart", as: "restart_game"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"
end
