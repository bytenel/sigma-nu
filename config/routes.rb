SigmaNew::Application.routes.draw do
  resources :articles do
    resources :posts, :shallow => true, :except => [:index]
  end


  resources :forums do
    resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'forums#index', :via => :get
  end

  devise_for :users

  resources :posts

  get "/dashboard", to: "user#dashboard", as: "dashboard"

  get "/calendar", to: "calendar#index"

  get "/recruitment", to: "home#recruitment"
  get "/bios", to: "home#bios"
  get "/alumni", to: "home#alumni"
  get "/about", to: "home#about"

  root to: "home#index"
end
