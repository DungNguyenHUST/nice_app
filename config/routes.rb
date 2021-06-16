Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users do
    resources :user_notifications
    resources :user_follows
  end
  
  resources :posts do
    resources :post_votes
    resources :post_unvotes
    resources :post_saves
    resources :post_comments do
      resources :post_comment_votes
      resources :post_comment_unvotes
      resources :post_comment_saves
    end
  end

  resources :tags do
    resources :tag_follows
  end

  resources :post_comments do
    resources :post_comments
  end

  resources :pages
  root "pages#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
