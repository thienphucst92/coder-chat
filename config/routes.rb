Rails.application.routes.draw do
  get 'index' => 'home#index'
  get 'inbox' => 'home#inbox'

  delete 'logout' => 'sessions#destroy'
  get 'login' => 'sessions#new'

  resources :users, only: [:new, :create, :index] do
    collection do
      get :friend_request
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
  resources :relationships, only: [:create]

  post 'accept' => 'relationships#accept_friend_request'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
