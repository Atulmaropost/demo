class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates :email, email: {strict_mode: true}
    has_many :galleries

    after_create :congrats_email
    # before_create :generate_password

	def congrats_email	
		@email =self.email
    @password =  self.password
	  ContactMailer.welcome_email(@email, @password).deliver_now
	end

  def self.generate_password
    random_string = ('a'..'z').to_a.shuffle.first(2).join
    random_integer = ('0'..'9').to_a.shuffle.first(7).join
    random_letter =  ('A'..'Z').to_a.shuffle.first(1).join
    password =  "#{random_string}#{random_integer}#{random_letter}"    
  end

end
