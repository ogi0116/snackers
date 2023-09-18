Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    get "search" => "searches#search"
    resources :items, only: [:new, :index, :show, :create, :destroy, :create] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      resource :reports, only: [:new, :create]
      get :complete, on: :member
    end
    resources :users, only: [:show, :edit, :update] do
       resources :products, only: [:new, :index, :show, :create, :edit, :update] do
         resources :reviews, only: [:create]
       end
       get :unscribe, on: :member
       patch :withdrawal, on: :member
      get :favorites, on: :member
      resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
    end
    resources :genres, only: [:show]
    resources :chats, only: [:show, :create]
  end

  namespace :admin do
    root to: "homes#top"
    get "search" => "searches#search"
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, only: [:new, :index, :show, :create, :destroy, :update]
   resources :reports, only: [:index]
   resources :users, only: [:show, :edit, :update]
  end


end
