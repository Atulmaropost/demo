class BackgroundWorker
  include Sidekiq::Worker

  def perform(contact_id)
  	@contact = Contact.find(contact_id)
  	ContactMailer.contact_us_email(@contact).deliver	    
  end
end
