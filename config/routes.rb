Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :buying_groups do
    resources :batches
    resources :orders do
      resources :order_items
    end
  end
end
