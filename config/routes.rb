Rails.application.routes.draw do
  require 'sidekiq/web'

  root to: 'home#index'

  mount ShopifyApp::Engine, at: '/'
  mount Sidekiq::Web => '/sidekiq'
end
