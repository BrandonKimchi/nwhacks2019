Rails.application.routes.draw do
  root 'blackmail#index'
  get 'sessions/new'
  get 'blackmail/index'
  get 'blackmail/register'
  post 'blackmail/create_account'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    'blackmail/login',   to: 'sessions#new'
  post   'blackmail/login',   to: 'sessions#create'
  delete 'blackmail/logout',  to: 'sessions#destroy'
  resources :users
end
