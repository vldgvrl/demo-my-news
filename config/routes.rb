Rails.application.routes.draw do
  resources :news, only: [:index, :show, :new, :create, :edit, :update]
  root 'news#index'
end
