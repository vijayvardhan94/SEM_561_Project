Rails.application.routes.draw do
<<<<<<< HEAD
  get '/about', to: 'pages#about'
  get '/login', to: 'pages#login'
  get '/', to: 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
=======
  get  'pages/about'
  get  'pages/login'
  get  'pages/index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


>>>>>>> fixed routing errors
