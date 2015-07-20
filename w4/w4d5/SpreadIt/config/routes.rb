Rails.application.routes.draw do
  resources :users, only: [:show, :create, :new]
  resource :session, only: [:create, :new, :destroy]

  resources :subs, except: :destroy
  resources :posts, except: [:destroy, :index] do
    resources :comments, only: [:new]
    post "upvote", to: "votes#upvote", as: "upvote"
    post "downvote", to: "votes#downvote", as: "downvote"
  end

  resources :comments, only: [:create, :show] do
    post "upvote", to: "votes#upvote", as: "upvote"
    post "downvote", to: "votes#downvote", as: "downvote"
  end

  root to: "subs#index"
end
