Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "games#index"
  resources :games, only: %w(index)

  match "move", to: "games#move", via: :post
  match "new", to: "games#new", via: :post
end
