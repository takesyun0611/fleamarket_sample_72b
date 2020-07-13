Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'shipments', to: 'users/registrations#new_shipment'
    post 'shipments', to: 'users/registrations#create_shipment'
  end
  root 'items#index'
  resources :products, only: [:index, :create]
  resources :users, only: :show do
    resources :cards, only: [:new, :create, :edit, :show]
  end
  resources :products do
    collection do
      get :searchChild
    end
    resources :comments, only: :create
  end
  resources :search, only: [:index]
end