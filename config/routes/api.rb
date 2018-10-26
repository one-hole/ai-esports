namespace :api do
  resources :schedule, only: [:index, :show]
  resources :verify_key, only: [:index]
  resources :live, only: [:index]
  resources :results, only: [:index, :show]
end
