# frozen_string_literal: true

Rails.application.routes.draw do
  resources :market_profiles
  resources :bars
  post 'bars/import', to: 'bars#import'
  resources :instruments
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
