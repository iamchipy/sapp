Rails.application.routes.draw do
  # Mount Rswag UI only in development and test environments
  if Rails.env.development? || Rails.env.test?  
    mount Rswag::Ui::Engine => "/api-docs"
    mount Rswag::Api::Engine => "/api-docs"
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # WEB interfaces
  resources :links
  root "links#index"
  get "/:short_code", to: "links#show", as: :short_link

  # APIs interfaces below here in their own namespace
  namespace :api do
    namespace :v1 do
      resources :links, defaults: { format: :json }
    end
  end
end
