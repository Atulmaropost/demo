class ContactMailer < ApplicationMailer
	default from: "atul.shukla8957@gmail.com"
	debugger
	def contact_us_email(contact)
		
    	@contact = contact
    	mail(to: @contact.email, subject: 'Thanks for contacting us')
  	end

  	def welcome_email(email)
 		@email = email
 		mail(to: @email, subject: 'you logged in successfully')
  	end

end
