class ContactMailer < ApplicationMailer
	default from: "atul.shukla8957@gmail.com"
	
	def contact_us_email(contact)		
    	@contact = contact
    	mail(to: @contact.email, subject: 'Thanks for contacting us')
  	end

  	def welcome_email(email, password)
 		@email = email
 		@password = password
 		mail(to: @email, subject: 'You logged in successfully')
  	end

end
