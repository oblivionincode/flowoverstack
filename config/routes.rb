Rails.application.routes.draw do
  root 'home#index'
  get '/help',    to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/faq',     to: 'static_pages#faq'
  get  '/signup',  to: 'users#new'
  get '/login',    to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

resources :users
  resources :answers
  resources :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

resources :posts do
  member do
    patch "upvote", to: "answers#upvote"
    patch "downvote", to: "answers#downvote"
  end
end
  end


