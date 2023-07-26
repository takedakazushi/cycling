Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :sessions => 'admin/sessions'
  }
  devise_for :customers
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    post '/homes/guest_sign_in', to: 'homes#new_guest'
    # devise_for :users を次に置き換える
    # devise_for :customers, controllers: {
    # registrations: 'custromers/registrations'
  # }
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end

    resources :customers, only: [:show, :index, :update, :edit]
    resources :post_images  do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      post 'confirm', on: :collection
  end
    end
  get '/search', to: 'public/searches#search'
  get 'maps/index', to: 'maps#index'
  resources :maps, only: [:index]
  # admin側ルーティング
  namespace :admin do
    get '' => 'homes#top'
    resources :customers, only: [:show, :index, :update, :edit]
  end
end