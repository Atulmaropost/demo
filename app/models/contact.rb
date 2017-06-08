class Contact < ApplicationRecord
	validates :my_email_attribute, email: {strict_mode: true}

end
