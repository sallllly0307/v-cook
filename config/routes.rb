Rails.application.routes.draw do

  get "/" => "home#top"

  get "/users/:id" => "users#show"
  get "/users/:id/edit" => "users#edit"
  post "/users/:id/update" => "users#update"
  get "/signup" => "users#new"
  post "/users/create" => "users#create"
  get "/login" => "users#login_form"
  post "/login" => "users#login"
  post "/logout" => "users#logout"

  get "/recipes/index" => "recipes#index"
  get "/recipes/new" => "recipes#new"
  post "/recipes/create" => "recipes#create"
  get "/recipes/:id" => "recipes#show"
  get "/recipes/:id/edit" => "recipes#edit"
  post "/recipes/:id/update" => "recipes#update"
  post "/recipes/:id/destroy" => "recipes#destroy"

  post "/likes/:recipe_id/create" => "likes#create"
  post "/likes/:recipe_id/destroy" => "likes#destroy"

  get "/users/:id/likes" => "users#likes"

  post "/recipes/search/index" => "recipes#searchIndex"

end
