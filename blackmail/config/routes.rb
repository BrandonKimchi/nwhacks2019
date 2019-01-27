Rails.application.routes.draw do
  get 'dashboard/view'
  get 'contract/create'
  post 'contract/new'
  post 'contract/view'
  post 'contract/complete'

  get 'sessions/new'
  get 'blackmail/index'

  get 'blackmail/register'
  post 'blackmail/create_account'
  get 'blackmail/login'
  post 'blackmail/newlogin'
  post 'blackmail/logout'
  get 'blackmail/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'blackmail#index'
end
