Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :admin do
    resources :buying_groups do
      resources :batches
    end
  end
end
