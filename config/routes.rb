Rails.application.routes.draw do
  root 'crops#index'

  resources :wishlists, except: [:show, :edit]
  resources :trades
  resources :crops, except: [:show]
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'signup' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  get 'users/:id' => 'users#show', as: :user
end
