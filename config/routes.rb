require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  get 'static_pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :subscribers
  # Defines the root path route ("/")
   root "static_pages#home"
   get '/unsubscribe', to: 'subscribers#unsubscribe'
   mount Sidekiq::Web => '/sidekiq'
end
