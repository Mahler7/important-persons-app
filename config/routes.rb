Rails.application.routes.draw do
  
  devise_for :users
  root 'important_persons#index'
  
  get '/' => 'important_persons#index'
  get '/important_persons/new' => 'important_persons#new'
  post '/important_persons' => 'important_persons#create'
  get '/important_persons/:id' => 'important_persons#show'
  get '/important_persons/:id/edit' => 'important_persons#edit'
  patch '/important_persons/:id' => 'important_persons#update'
  delete '/important_persons/:id' => 'important_persons#destroy'

  get '/events/new' => 'events#new'
  post '/events' => 'events#create'
  get 'events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'

end
