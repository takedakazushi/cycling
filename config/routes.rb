Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    post '/homes/guest_sign_in', to: 'homes#new_guest'
    # devise_for :users を次に置き換える
    # devise_for :customers, controllers: {
    # registrations: 'custromers/registrations'
  # }

    resources :customers, only: [:show, :index, :update, :edit]
    resources :post_images  do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  get '/search', to: 'searches#search'
  end
  # admin側ルーティング
  namespace :admin do
    get '' => 'homes#top'
    resources :customers, only: [:show, :index, :update, :edit]
  end
end