Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "storefronts#index", id: 1

  resources :storefronts do
    patch 'reasons/update_order', on: :member, to: 'reasons#update_order', as: 'update_reason_order'
  end

  resources :reasons do
    member do
      patch :toggle_active
    end
  end

end
