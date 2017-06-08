Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
   resources :gallery	
	 		
  root 'home#about_us'
  get '/contact_us' => 'home#contact_us'
  get '/about_us' => 'home#about_us'
  post '/message' => 'home#message'
end
