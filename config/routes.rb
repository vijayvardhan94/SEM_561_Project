Rails.application.routes.draw do
  mount Dashing::Engine, at: Dashing.config.engine_path
  #mount Dashing::Engine, at: '/dashing/dashboard'
  devise_for :users 
    get '/users' => 'users#user', as: :user_root # creates user_root_path 
    #delete 'users/sign_out' => 'devise/sessions#destroy'
    get '/users/profile' => 'users#profile'
    get 'users/sync'     => 'users#sync'
    post 'users/sync'     
    #gepost '/login' => 'pages#login' as:  :user_root

    
namespace :users do
  root 'users#user' # creates user_root_path
  #get 'users#sign_out' => 'devise/sessions#destroy'
  get '/users/profile' => 'users#profile'
  get 'users/sync'     => 'users#sync'
end


  get  'pages/about'
  get  'pages/login'
  get  'pages/index'
  get  'pages/dashboard'  
  root :to => "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
