Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'important_persons#home', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end
  
  root 'important_persons#home'
  
  get '/' => 'important_persons#home'
  get '/important_persons' => 'important_persons#index'
  get '/important_persons/new' => 'important_persons#new'
  post '/important_persons' => 'important_persons#create'
  get '/important_persons/:id' => 'important_persons#show'
  get '/important_persons/:id/edit' => 'important_persons#edit'
  patch '/important_persons/:id' => 'important_persons#update'
  delete '/important_persons/:id' => 'important_persons#destroy'

  get '/events' => 'events#index'
  get '/events/new' => 'events#new'
  post '/events' => 'events#create'
  get '/events/calendar' => 'events#calendar'
  get 'events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'
  get '/events/reminder/:id' => 'events#reminder'

  get '/wishlist_items' => 'wishlist_items#index'
  get '/wishlist_items/new' => 'wishlist_items#new'
  post '/wishlist_items' => 'wishlist_items#create'
  get '/wishlist_items/:id' => 'wishlist_items#show'
  get '/wishlist_items/:id/edit' => 'wishlist_items#edit'
  patch '/wishlist_items/:id' => 'wishlist_items#update'
  delete '/wishlist_items/:id' => 'wishlist_items#destroy'

  get '/messages' => 'messages#index'
  get '/messages/new' => 'messages#new'
  get '/messages/select' => 'messages#select_message'
  post '/messages' => 'messages#create'
  get '/messages/:id' => 'messages#show'
  get '/messages/:id/edit' => 'messages#edit'
  patch '/messages/:id' => 'messages#update'
  delete '/messages/:id' => 'messages#destroy'

  get '/messages/send_email/:id' => 'messages#send_email'
  get '/messages/send_email_later/:id' => 'messages#send_email_later'
  get '/messages/send_sms/:id' => 'messages#send_text'
  get '/messages/send_sms_later/:id' => 'messages#send_text_later'
  get '/messages/send_tweet/:id' => 'messages#tweet'

end
