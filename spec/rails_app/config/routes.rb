RailsApp::Application.routes.draw do
  devise_for :users
  get '/secure', :to => 'home#secure'
  root :to => 'home#index'
end
