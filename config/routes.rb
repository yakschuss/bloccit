Rails.application.routes.draw do

  resources :labels, only: [:show]

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote'=> 'votes#down_vote', as: :down_vote
  end


  resources :users, only: [:new, :create, :show] do
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

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]
      resources :topics, except: [:edit, :new]
    end
  end
end
