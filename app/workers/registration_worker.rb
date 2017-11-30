class RegistrationWorker
  include Sidekiq::Worker

  def perform(email, password)
  	@email = email
  	@password = password
  	ContactMailer.welcome_email(@email, @password).deliver	    
  end
end