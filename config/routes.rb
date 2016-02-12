Rails.application.routes.draw do
  devise_for :users
  root 'important_persons#index'
  get '/' => 'important_persons#index'
end
