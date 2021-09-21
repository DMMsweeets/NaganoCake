Rails.application.routes.draw do


  get 'rails/g'
  get 'rails/controller'
  get 'rails/searches'
   devise_for :members, controllers: {
    sessions:      'public/members/sessions',
    passwords:     'public/members/passwords',
    registrations: 'public/members/registrations'
   }



   devise_for :admins, controllers: {
    sessions:      'admin/admins/sessions',
    passwords:     'admin/admins/passwords',
    registrations: 'admin/admins/registrations'
   }


  root 'homes#top'


  get 'homes/about'

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :orders, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :order_details, only: [:update]
  end

  namespace :public do
    resources :deliveries, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :public do
    get 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'
    resources :orders, only: [:index, :new, :show, :create]
  end

  namespace :public do
    get 'search' => 'items#search'
    resources :items, only: [:index, :show]
  end

  namespace :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :create, :destroy, :update]
  end

  namespace :public do
    get 'members/mypage' => 'members#show', as: 'mypage'
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/withdrawal' => 'members#withdrawal', as: 'withdrawal'
    resources :members, only: [:edit, :update]
  end

  namespace :public do
    resources :genres, only: [:show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
