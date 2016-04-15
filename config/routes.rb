# == Route Map
#
#                    Prefix Verb     URI Pattern                            Controller#Action
#               users_index GET      /users/index(.:format)                 users#index
#                users_show GET      /users/show(.:format)                  users#show
#          new_user_session GET      /users/sign_in(.:format)               users/sessions#new
#              user_session POST     /users/sign_in(.:format)               users/sessions#create
#      destroy_user_session DELETE   /users/sign_out(.:format)              users/sessions#destroy
#   user_omniauth_authorize GET|POST /users/auth/:provider(.:format)        users/omniauth_callbacks#passthru {:provider=>/facebook|twitter/}
#    user_omniauth_callback GET|POST /users/auth/:action/callback(.:format) users/omniauth_callbacks#:action
#             user_password POST     /users/password(.:format)              users/passwords#create
#         new_user_password GET      /users/password/new(.:format)          users/passwords#new
#        edit_user_password GET      /users/password/edit(.:format)         users/passwords#edit
#                           PATCH    /users/password(.:format)              users/passwords#update
#                           PUT      /users/password(.:format)              users/passwords#update
#  cancel_user_registration GET      /users/cancel(.:format)                users/registrations#cancel
#         user_registration POST     /users(.:format)                       users/registrations#create
#     new_user_registration GET      /users/sign_up(.:format)               users/registrations#new
#    edit_user_registration GET      /users/edit(.:format)                  users/registrations#edit
#                           PATCH    /users(.:format)                       users/registrations#update
#                           PUT      /users(.:format)                       users/registrations#update
#                           DELETE   /users(.:format)                       users/registrations#destroy
#         user_confirmation POST     /users/confirmation(.:format)          devise/confirmations#create
#     new_user_confirmation GET      /users/confirmation/new(.:format)      devise/confirmations#new
#                           GET      /users/confirmation(.:format)          devise/confirmations#show
#              company_show GET      /company/show(.:format)                company#show
#                     about GET      /about(.:format)                       about#company_overview
#             inquiry_index GET      /inquiry/index(.:format)               inquiry#index
#                           POST     /inquiry/index(.:format)               inquiry#index
#           inquiry_confirm POST     /inquiry/confirm(.:format)             inquiry#confirm
#            inquiry_thanks POST     /inquiry/thanks(.:format)              inquiry#thanks
#                     blogs GET      /blogs(.:format)                       blogs#index
#                           POST     /blogs(.:format)                       blogs#create
#                  new_blog GET      /blogs/new(.:format)                   blogs#new
#                 edit_blog GET      /blogs/:id/edit(.:format)              blogs#edit
#                      blog GET      /blogs/:id(.:format)                   blogs#show
#                           PATCH    /blogs/:id(.:format)                   blogs#update
#                           PUT      /blogs/:id(.:format)                   blogs#update
#                           DELETE   /blogs/:id(.:format)                   blogs#destroy
#                     users GET      /users(.:format)                       users#index
#                      user GET      /users/:id(.:format)                   users#show
#                      root GET      /                                      top#index
# rambulance_exceptions_app          /rambulance                            Rambulance::ExceptionsApp
#

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
end
