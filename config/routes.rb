Rails.application.routes.draw do

  resources :buying_groups do
    resources :batches
  end
end
