Rails.application.routes.draw do
  # require 'sidekiq/web'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users 
  devise_for :users, :controllers => {:registrations => "users/registrations", sessions: "users/sessions"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  resources :gallery	
	 		
  root 'home#about_us'
  get '/contact_us' => 'home#contact_us'
  get '/about_us' => 'home#about_us'
  post '/message' => 'home#message'
  post '/import_image' => 'gallery#import_image'
  get '/get_image/:id', to: 'gallery#get_image', as: 'get_image'
  get '/gallery_count', to: 'gallery#gallery_count'


  
  # mount Sidekiq::Web => '/sidekiq'

end
