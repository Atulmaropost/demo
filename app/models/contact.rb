class Contact < ApplicationRecord
	
	validates :email, email: {strict_mode: true}

end
