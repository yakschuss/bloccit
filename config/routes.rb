Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  post 'confirm' => 'users#confirm'

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
