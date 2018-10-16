Rails.application.routes.draw do
  get  'pages/about'
  get  'pages/login'
  get  'pages/index'
  get  'pages/dashboard'
  root :to => "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

