Rails.application.routes.draw do

	root to: 'rooms#list'

  get 'rooms/list'
  get 'rooms/show'
  post 'rooms/new'

	mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
