Rails.application.routes.draw do
  mount Dashing::Engine, at: Dashing.config.engine_path
  #mount Dashing::Engine, at: '/dashing/dashboard'
  devise_for :users 
    get '/users' => 'users#profile', as: :user_root # creates user_root_path 
    #delete 'users/sign_out' => 'devise/sessions#destroy'
    get '/users/profile' => 'users#profile'
    #gepost '/login' => 'pages#login' as:  :user_root

    
namespace :users do
  root 'users#profile' # creates user_root_path
  #get 'users#sign_out' => 'devise/sessions#destroy'
  get '/users/profile' => 'users#profile'
end


  get  'pages/about'
  get  'pages/login'
  get  'pages/index'
  get  'pages/dashboard'  
  root :to => "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


