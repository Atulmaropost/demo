class RegistrationWorker

  def perform(email, password)
  	@email = email
  	@password = password
  	ContactMailer.welcome_email(@email, @password).deliver	    
  end
end