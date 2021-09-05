Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :books
  resources :users

  get 'home/about' => 'homes#index'
  get 'books' => 'books#index'
  post 'books' => 'books#create'
  get 'books/:id' => 'books#show', as: 'booklist'
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show', as: 'userlist'
  delete 'books/:id' => 'books#destroy'

end
