require 'resque'
require 'resque_web'
require 'resque-scheduler'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Resque::Server => '/resque'
  namespace :api, defaults: {format: :json} do
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    post '/posts/:id/comments' => 'comments#create'
    get '/posts/:id/comments' => 'comments#index'
    get '/comments' => 'comments#index'
    get '/user' => 'users#logged_in_user'

    post 'posts/:id/like' => 'posts#create_like'
    post 'posts/:id/view' => 'posts#create_view'
    resources :users, :posts
  end

end
