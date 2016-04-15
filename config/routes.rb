Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords",
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  get 'company/show'     => 'company#show'
  get 'about'            => 'about#company_overview'
  get 'inquiry/index'    => 'inquiry#index'
  post 'inquiry/index'   => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks'  => 'inquiry#thanks'

  resources :blogs
  resources :users, only: [:index, :show]

  root 'top#index'

  # 404を捕捉
  match "*path" => "application#handle_404", via: :all
end
