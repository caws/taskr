Rails.application.routes.draw do
  # Resources
  resources :tasks

  # Root
  root 'home#index'

  # Home
  get 'home/about', to: 'home#about', as: :about

  # AṔI
  namespace :api do
    namespace :v1 do
      resources :tasks
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
