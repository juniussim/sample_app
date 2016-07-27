Rails.application.routes.draw do
	root 'static_pages#home'
  get '/help', to: 'static_pages#help'
	get '/about', to: 'static_pages#about'
	get  '/contact', to: 'static_pages#contact'
	# changing contact_path into boom_path to refer to /contact
	# get  '/contact', to: 'static_pages#contact', as: 'boom'
	get  '/signup',  to: 'users#new'
	post '/signup',  to: 'users#create'
	resources :users
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
