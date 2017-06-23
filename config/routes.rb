Rails.application.routes.draw do
  get 'index' => 'home#index'
  get 'inbox' => 'home#inbox'

  delete 'logout' => 'sessions#destroy'
  get 'login' => 'sessions#new'

  resources :users, only: [:new, :create, :index]
  resources :sessions, only: [:new, :create, :destroy]

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
