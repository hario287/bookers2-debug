Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
devise_for :users
  root 'homes#top'
  get "/home/about" => "homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # chats_controllerのshowアクションでチャットを行う
  #get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create, :show]

  #グループ機能
  resources :groups, only: [:new, :index, :show, :create, :edit, :update]

  get 'search' => 'searches#search'
end