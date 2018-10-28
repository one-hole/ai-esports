namespace :api do
  resources :schedule,   only: [:index, :show]
  resources :verify_key, only: [:index]
  resources :live,       only: [:index, :show]
  resources :results,    only: [:index, :show]
  resources :teams,      only: [:show]
  resources :teamvs,     only: [:show]
end
