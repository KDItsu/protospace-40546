Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"#トップページを決めている
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show

  resources :users, only: :show
  
end
