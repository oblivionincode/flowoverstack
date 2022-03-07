Rails.application.routes.draw do
  root 'questions#index'
  get '/help',    to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/faq',     to: 'static_pages#faq'
  get  '/signup',  to: 'users#new'
  get '/login',    to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'tags/:tag', to: 'questions#index', as: :tag




  resources :users
  resources :questions do
    resources :comments, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
resources :answers do

  resources :comments, only: [:new, :create, :destroy]

  member do
    patch "upvote", to: "answers#upvote"
    patch "downvote", to: "answers#downvote"
  end

end
  end



