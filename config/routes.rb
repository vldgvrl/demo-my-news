Rails.application.routes.draw do
  resources :news, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  root 'news#index'
end
