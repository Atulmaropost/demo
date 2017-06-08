class ApplicationController < ActionController::Base	
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	if resource.class.to_s.eql? "User"   
    	about_us_path
    else	
    	admin_dashboard_url
    end	
	end

end
