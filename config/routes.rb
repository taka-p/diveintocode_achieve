Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords",
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  get 'users/index'
  get 'users/show'

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
  resources :relationships, only: [:create, :destroy]
  get 'relationships/create'
  get 'relationships/destroy'

  resources :questions do
    resources :answers
  end
  resources :answers

  resources :users, only: [:index, :show, :edit, :update] do
    resources :tasks
    member do
      get :following, :followers
    end
  end

  namespace :taskline do
    resources :tasks do
      resources :comment
      post 'goodjob'
      post 'ungoodjob'
    end
  end

  scope module: :project do
    resources :projects do
      resources :tasks, except: :destroy
      delete 'tasks/:id' => 'tasks#sub_destroy'
      resources :members
    end
    resources :customers
  end

  namespace :taskline do
    resources :task_comments
  end

  resources :tasks

  root 'top#index'
end
