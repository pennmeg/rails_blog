Rails.application.routes.draw do
  get "/" => "users#home"
  get "/home" => "users#home"
  get "/my_posts" => "posts#my_posts"
  get "/login_form" => "users#login_form"
  post "/login" => "users#login"
  get "/logout" => "users#logout"
  get "/new_comment/:user_id/:post_id" => "comments#new"
  get "/profile_posts/:id" => "posts#profile_posts"
  get "/my_comments" => "comments#my_comments"

  resources :users do
    resources :posts
  end
  resources :comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
