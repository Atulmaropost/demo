class HomeController < ApplicationController
	
	before_action :authenticate_user!	
	def index
		
	end

	def about_us
		
	end

	def contact_us
		
	end

	def message
		@contact = Contact.new(contact_params)
	  @contact.save
  	respond_to do |format|
    	if @contact.save

      	# Sends email to user when user is created.
      	ContactMailer.contact_us_email(@contact).deliver

      	format.html { redirect_to root_path, notice: 'Contact was successfully Send.' }
      	format.json { render :show, status: :created, location: @contact}
    	else
      	format.html { render :contact_us }
      	format.json { render json: @contact.errors, status: :unprocessable_entity }
    	end
		end
 	end	 
		
	private
	  def contact_params
	    params.require(:contact).permit(:name, :email, :mobile_number, :description)
	  end

end
