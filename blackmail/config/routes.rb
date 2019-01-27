Rails.application.routes.draw do
  get 'dashboard/view'
  get 'contract/create'
  get 'contract/download'
  post 'contract/new'
  get 'sessions/new'
  get 'blackmail/index'

  get 'blackmail/register'
  post 'blackmail/create_account'
  get 'blackmail/login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'blackmail#index'
end
