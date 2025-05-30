Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "game", to: "game#new"

  get "play_with_computer", to: "game#play_with_computer", as: "play_with_computer"
  get "how_to_play", to: "pages#how_to_play", as: "how_to_play"
  post "game/move", to: "game#move", as: "game_move"
  post "game/reset", to: "game#reset", as: "reset_game"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"
end
