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
    resources :post_follows
    resources :post_comments
    resources :post_reports
  end

  resources :post_comments do
    resources :post_comment_votes
    resources :post_comment_reports
  end

  resources :categories do
    resources :topics
  end

  resources :topics do
    resources :topic_follows
    resources :topic_reports
  end

  resources :post_comments do
    resources :post_comments
  end

  resources :pages

  resources :scrapers

  get 'page_search' => 'pages#search'
  root "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
