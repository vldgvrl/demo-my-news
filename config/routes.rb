Rails.application.routes.draw do
  resources :news, only: [:index, :show, :new, :create, :edit, :update, :destroy, :picture]
  root 'news#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
