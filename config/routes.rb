Rails.application.routes.draw do
  resources :rooms
  devise_for :users, controllers: {sessions: "users/sessions"}
  resources :messages
  root to: 'rooms#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
