Rails.application.routes.draw do
  mount Dashing::Engine, at: Dashing.config.engine_path
  devise_for :users
  get '/users' => 'users#profile', as: :user_root # creates user_root_path
  #post '/login' => 'pages#login' as:  :user_root

namespace :user do
  root 'users#profile' # creates user_root_path
  get 'users/sign_out' => 'users/sessions#destroy'
end


  get  'pages/about'
  get  'pages/login'
  get  'pages/index'
  get  'pages/dashboard'
  #get  'pages/profile'
  root :to => "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
