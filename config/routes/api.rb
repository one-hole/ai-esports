namespace :api do
  resources :schedule,   only: [:index, :show]
  resources :verify_key, only: [:index]
  resources :live,       only: [:index, :show]
  resources :results,    only: [:index, :show]
  resources :teams,      only: [:show]
  resources :teamvs,     only: [:show]
  resources :leagues,    only: [:show, :index]

  namespace :constants do
    resources :dota2_heroes,    only: [:index, :show]
    resources :dota2_items,     only: [:index, :show]
    resources :dota2_abilities, only: [:index, :show]
  end
end
