Rails.application.routes.draw do
  get 'contract/create'
  get 'contract/download'
  get 'sessions/new'
  get 'blackmail/index'

  get 'blackmail/register'
  post 'blackmail/create_account'
  get 'blackmail/login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'blackmail#index'
end
