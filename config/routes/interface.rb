namespace :interface do
  resources :games, only: [:index]
  resources :teams, only: [:index]
  resources :leagues, only: [:index]
  resources :series, only: [:index]
  resources :tournaments, only: [:index]
  resources :battles, only: [:index]
end