NTouch::Application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  root 'welcome#index'

  resources :users do
    resources :friends
  end

  get 'search' => 'users#search'
end
