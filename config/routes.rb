Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :users, only: [:index, :edit, :update, :destroy]

  resources :companies do
    resources :data_sheets, except: [:index, :show]
  end
end
