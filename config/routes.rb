Rails.application.routes.draw do
  resources :news, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :booktime, only: [:index, :new]
  root 'news#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'booktime', to: 'booktime#new'
end
