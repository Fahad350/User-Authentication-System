Rails.application.routes.draw do
  #get "sessions/new"
 # get "users/new"
  get "/help", to: "static_pages#help", as:"helf"
  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/news", to: "static_pages#news"
  # get "static_pages/about"
  # get "static_pages/help"
  
   #get "static_pages/home"
   get "/signup", to: "users#signup"
   #get "/login", to: "users#login"
  
   root "application#hello"

   get "/login", to: "sessions#new"
   post "/login", to: "sessions#create"
   delete "/logout", to: "sessions#destroy"
   #get "/", to: "www.google.com"
   resources :users
   # root "static_pages#home"
  
   #root should be one in rails otherwise application crash
end
