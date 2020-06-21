Rails.application.routes.draw do
  root 'items#index'
  resources :products, except: :show
end
