# For details on the DSL available within this file, see
# https://guides.rubyonrails.org/routing.html

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'user_files#index'

  resources :user_files, only: [:index, :show, :new, :create]

  mount Sidekiq::Web => '/sidekiq'
end
