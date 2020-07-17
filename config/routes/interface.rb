namespace :interface do
  resources :games, only: [:index]
  resources :teams, only: [:index]
  resources :battles, only: [:index]
end