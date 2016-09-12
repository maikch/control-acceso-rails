Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to:  'login#show'
  get 'login' => 'course#list'
  get 'logout' => 'login#logout'
  get 'event' => 'event#new'
end
