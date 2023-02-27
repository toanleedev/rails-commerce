# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  scope '(:locale)', locale: /en|vi/ do
    root 'static_pages#index'
    # resources :users, only: [:new, :create]
    get 'sign_up', to: 'users#new'
    post 'sign_up', to: 'users#create'
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :users, only: [:confirmation] do
      get 'confirmation', on: :collection
    end
    namespace :admin do
      resource :dashboard
    end
  end
end
