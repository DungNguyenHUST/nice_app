Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  get 'user_wellcome' => 'users#wellcome'
  
  resources :users do
    resources :user_notifications
    resources :user_follows
  end
  
  resources :posts do
    resources :post_votes
    resources :post_unvotes
    resources :post_follows
    resources :post_comments
  end

  resources :post_comments do
    resources :post_comment_votes
    resources :post_comment_unvotes
  end

  resources :tags do
    resources :tag_follows
  end

  resources :post_comments do
    resources :post_comments
  end

  resources :pages
  get 'page_search' => 'pages#search'
  root "pages#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
