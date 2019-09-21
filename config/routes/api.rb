namespace :api do
  resources :schedule,   only: [:index, :show]
  resources :nonsig_schedule , only: [:index]
  resources :verify_key, only: [:index]
  resources :live,       only: [:index, :show]
  resources :results,    only: [:index, :show]
  resources :teams,      only: [:show, :index]
  resources :teamvs,     only: [:show]
  resources :leagues,    only: [:show, :index]
  resources :csgo_bp,    only: [:show]
  resources :players,    only: [:index]

  resources :topics,     only: [:index]

  namespace :constants do
    resources :dota2_heroes,    only: [:index, :show]
    resources :dota2_items,     only: [:index, :show]
    resources :dota2_abilities, only: [:index, :show]
    resources :csgo_maps,       only: [:index]
    resources :lol_heroes,      only: [:index, :show]
  end

  namespace :v2 do
    resources :lives, only: [:index, :show]
  end
end
