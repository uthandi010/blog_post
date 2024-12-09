Rails.application.routes.draw do
  resources :users, only: [ :new, :create ] do
    member do
      get :profile
    end
  end

  resources :blog_posts do
    resources :comments, only: [ :create, :edit, :update, :destroy ] do
      member do
        get :reply
      end
    end
  end

  resources :home

  root "home#index"

  # get '/sign_in', to: 'sessions#new', as: 'sign_in'
  get "/sign_in", to: "sessions#new", as: "sign_in"
  post "/sign_in", to: "sessions#create"

  delete "/sign_out", to: "sessions#destroy", as: "sign_out"

  get "/sign_up", to: "users#new", as: "sign_up"
  post "/sign_up", to: "users#create"
  # post '/users', to: 'users#create'
  delete "/home/:id", to: "home#destroy", as: "user_delete"

  get "/admin/users", to: "users#index", as: "admin_users"

  resources :blog_posts
end
