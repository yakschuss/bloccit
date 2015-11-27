Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end


  resources :users, only: [:new, :create] do
    collection do
        post :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]


  resources :welcome, only: [:index] do
    collection do
      get :about #, as: 'about'
    end
  end


  root to: 'welcome#index'
end
