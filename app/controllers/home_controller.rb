class HomeController < ApplicationController
	
	before_action :authenticate_user!	

	def about_us
		
	end

	def contact_us
		
	end

	def message
		@contact = Contact.new(contact_params)
	  respond_to do |format|
	  	if @contact.save
    		ContactMailer.contact_us_email(@contact).deliver
    		flash[:success] = "Your message has been send"
        format.json { render json: { status: "Success", message: "Successful", code: 200 } }	
    	else
    		 format.json { render json: { status: "Failure", message: @query.errors.full_messages, code: 500 } }
    	end 
    end	
 	end	 
		
	private
	  def contact_params
	    params.require(:contact).permit(:name, :email, :mobile_number, :description)
	  end

end
