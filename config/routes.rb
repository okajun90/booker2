Rails.application.routes.draw do

  devise_for :users
  root to: 'tops#top'
  resources :users
  resources :books
  get 'home/about', to: 'tops#about'
  
end
