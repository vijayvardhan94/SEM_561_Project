Rails.application.routes.draw do
  devise_for :users
  get '/users' => 'pages#login', as: :user_root # creates user_root_path
  #post '/login' => 'pages#login' as:  :user_root

namespace :user do
  root 'pages#login' # creates user_root_path
end


  get  'pages/about'
  get  'pages/login'
  get  'pages/index'
  get  'pages/dashboard'
  get  'pages/profile'
  root :to => "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
