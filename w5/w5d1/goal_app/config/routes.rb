Rails.application.routes.draw do
  root to: "goals#index"

  resources :users, except: :destroy
  resources :goals
  resource :session, only: [:new, :create, :destroy]
  resources :user_comments, only: [:create]
  resources :goal_comments, only: [:create]
end
