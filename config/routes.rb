Rails.application.routes.draw do
  resources :posts do
    resources :post_votes
    resources :post_unvotes
    resources :post_saves
    resources :post_comments
  end

  resources :post_comments do
    resources :post_comments
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :pages
  root "pages#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
