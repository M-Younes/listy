Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'lists#index'
  resources :lists do 
  	delete 'delete', on: :member
  	post 'restore', on: :member
  	get 'trash', on: :collection
  end
  resources :list_items, only: [:show, :destroy] do 
  	delete 'delete', on: :member
  	post 'restore', on: :member
  end
  resources :tag_items, only: [:create, :destroy] do
    delete 'delete', on: :member
    post 'restore', on: :member
  end
end
