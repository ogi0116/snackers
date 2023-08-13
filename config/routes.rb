Rails.application.routes.draw do

  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
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

    resources :items, only: [:new, :index, :show, :create, :destroy, :create]
    resources :users, only: [:show, :edit]
  end


end
