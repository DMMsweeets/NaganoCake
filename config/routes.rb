Rails.application.routes.draw do
  namespace :public do
    get 'members/show'
  end
  get 'homes/top'
  get 'homes/about'
  devise_for :members, controllers: {
    sessions:      'members/sessions',
    passwords:     'members/passwords',
    registrations: 'members/registrations'
  }

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :admin do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
  end
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'deliveries/index'
    get 'deliveries/edit'
  end
  namespace :public do
    get 'order/index'
    get 'order/show'
    get 'order/new'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
