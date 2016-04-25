Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords",
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  get 'company/show' => 'company#show'
  get 'about' => 'about#company_overview'

  get 'inquiry/index' => 'inquiry#index'
  get 'inquiry/list' => 'inquiry#list'
  get 'inquiry/show' => 'inquiry#show'
  get 'inquiry/receive_email' => 'inquiry#receive_email'
  post 'inquiry/index' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'


  resources :blogs do
    resources :comments
  end
  resources :comments

  resources :questions do
    resources :answers
  end
  resources :answers

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  root 'top#index'
end
