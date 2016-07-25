Rails.application.routes.draw do
	root 'static_pages#home'
	get 'static_pages/home'
	# Alternative way of writing
	# get 'home', to: 'static_pages#home'
  get 'static_pages/help'
	get 'static_pages/about'
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
