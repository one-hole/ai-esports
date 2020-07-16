namespace :interface do
  resources :games, only: [:index]
  resources :battles, only: [:index]
end