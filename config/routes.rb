Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # WEB interfaces
  resources :links #, only: [ :index, :new, :create, :show ]
  root "links#new" # Or 'links#index' depending on desired homepage
  get "/:short_code", to: "links#show", as: :short_link

  # APIs interfaces below here in their own namespace
  namespace :api do
    namespace :v1 do
      resources :links, defaults: { format: :json }
    end
  end
end
