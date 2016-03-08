Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
     authenticated :user do
       root 'important_persons#index', as: :authenticated_root
     end

     unauthenticated do
       root 'devise/registrations#new', as: :unauthenticated_root
     end
   end
  root 'important_persons#index'
  
  get '/' => 'important_persons#index'
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
  get 'events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'

  get '/wishlist_items' => 'wishlist_items#index'
  get '/wishlist_items/new' => 'wishlist_items#new'
  post '/wishlist_items' => 'wishlist_items#create'
  get '/wishlist_items/:id' => 'wishlist_items#show'
  get '/wishlist_items/:id/edit' => 'wishlist_items#edit'
  patch '/wishlist_items/:id' => 'wishlist_items#update'
  delete '/wishlist_items/:id' => 'wishlist_items#destroy'

  get '/messages' => 'messages#index'
  get '/messages/new' => 'messages#new'
  post '/messages' => 'messages#create'
  get '/messages/:id' => 'messages#show'
  get '/messages/:id/edit' => 'messages#edit'
  patch '/messages/:id' => 'messages#update'
  delete '/messages/:id' => 'messages#destroy'

  post '/messages/send_email/:id' => 'messages#send_email'
  post '/messages/send_email_later/:id' => 'messages#send_email_later'

end
