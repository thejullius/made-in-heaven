Rails.application.routes.draw do
  root to: 'buying_groups#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :buying_groups do
    resources :batches
    resources :orders do
      resources :order_items
    end
  end

  resources :orders do
    collection do
      post :shipment_options
    end
  end
end
