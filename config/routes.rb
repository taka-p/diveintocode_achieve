Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users
  get 'company/show' => 'company#show'
  get 'inquiry/index' => 'inquiry#index'
  post 'inquiry/index' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'
  resources :blogs
  resources :users, only: [:index, :show]

  root 'top#index'
end
