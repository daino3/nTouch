NTouch::Application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'



  resources :users do
    resources :friends
  end

  resources :friends do
    resources :events, only: [:new, :create]
  end

  get 'search' => 'users#search'
  root 'welcome#index'
end
