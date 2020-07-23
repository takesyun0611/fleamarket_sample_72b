Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'shipments', to: 'users/registrations#new_shipment'
    post 'shipments', to: 'users/registrations#create_shipment'
    resources :shipments, only: [:edit, :update]
  end
  root 'items#index'
  resources :products, only: [:index, :create, :destroy] do
    get 'buy','products/buy'
  end
  resources :users, only: :show do
    resources :cards, only: [:new, :create, :show, :edit, :destroy]
    post 'pay','cards/pay'
  end
  resources :products do
    collection do
      get :get_category_children, defaults: { format: 'json'}
      get :get_category_grandchildren, defaults: { format: 'json'}
      get :searchChild
      get :update_done
    end
    resources :comments, only: :create
  end
  resources :search, only: [:index]
end