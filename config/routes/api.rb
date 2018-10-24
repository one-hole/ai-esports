namespace :api do
  resources :schedule, only: [:index]
  resources :verify_key, only: [:index]
end
