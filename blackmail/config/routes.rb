Rails.application.routes.draw do
  root 'blackmail#index'
  get 'sessions/new'
  get 'blackmail/index'

  get 'blackmail/register'
<<<<<<< HEAD
=======
  post 'blackmail/create_account'
  get 'blackmail/login', to: 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
>>>>>>> master

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    'blackmail/login',   to: 'sessions#new'
  post   'blackmail/login',   to: 'sessions#create'
  delete 'blackmail/logout',  to: 'sessions#destroy'
  resources :users
end
