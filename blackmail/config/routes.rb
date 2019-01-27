Rails.application.routes.draw do
  get 'blackmail/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'blackmail#index'
end
