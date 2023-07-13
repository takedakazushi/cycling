Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    get 'couse' => 'couse#index'
    resources :customers, only: [:show, :index, :update, :edit]
    resources :post_images, only: [:new, :create, :index, :show]
  end
  # admin側ルーティング
  namespace :admin do
    get '' => 'homes#top'
    get 'couse' => 'couse#index'
    resources :customers, only: [:show, :index, :update, :edit]
  end
end