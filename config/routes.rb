Rails.application.routes.draw do
  namespace :admin do
    resources :buying_groups do
      resources :batches
    end
  end
end
