Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
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
