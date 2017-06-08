class HomeController < ApplicationController
	
	before_action :authenticate_user!	

	def about_us
		
	end

	def contact_us
		
	end

	def message
		@contact = Contact.new(contact_params)
	  @contact.save
    ContactMailer.contact_us_email(@contact).deliver
    flash[:success] = "Your message has been send"
 	end	 
		
	private
	  def contact_params
	    params.require(:contact).permit(:name, :email, :mobile_number, :description)
	  end

end
