Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'shipments', to: 'users/registrations#new_shipment'
    post 'shipments', to: 'users/registrations#create_shipment'
  end
  root 'items#index'
  resources :products, except: :show do
    collection do
      get :searchChild
    end
  end
end
