class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :galleries

    after_create :congrats_email

	def congrats_email	
		@email =self.email
	  ContactMailer.welcome_email(@email).deliver_now
	end
end
