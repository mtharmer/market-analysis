# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app
  resources :market_profiles
  post 'market_profiles/generate', to: 'market_profiles#generate'
  post 'market_profiles/recalculate', to: 'market_profiles#recalculate'
  resources :bars
  post 'bars/import', to: 'bars#import'
  resources :instruments
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
