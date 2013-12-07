require 'sidekiq/web'

NTouch::Application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  resources :users do
    resources :friends
  end

  resources :friends do
    resources :events
  end

  #this is for retrieving friend data and rendering a partial
  get 'user/interaction_data' => 'users#interaction_data', as: 'get_friend_data'

  get 'user/:id/settings' => 'users#settings', as: 'user_settings'

  get 'user/:id/events' => 'users#show_events', as: 'user_events'

  get 'search' => 'friends#search'
  root 'welcome#index'

end
