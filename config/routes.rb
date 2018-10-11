Rails.application.routes.draw do
  resources :homes
  resources :questions do
    resources :answers
  end
  resources :answers
  root 'questions#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
