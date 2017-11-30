class ApplicationController < ActionController::Base   

  protect_from_forgery unless: -> { request.format.json? }
  acts_as_token_authentication_handler_for User, if: lambda { |controller| controller.request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
  	if resource.class.to_s.eql? "User" 
    	about_us_path
    else	
    	admin_dashboard_url
    end	
	end



  private
	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end

end
