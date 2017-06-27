class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates :email, email: {strict_mode: true}
    has_many :galleries

    # before_create :generate_password



  def self.generate_password
    random_string = ('a'..'z').to_a.shuffle.first(2).join
    random_integer = ('0'..'9').to_a.shuffle.first(7).join
    random_letter =  ('A'..'Z').to_a.shuffle.first(1).join
    password =  "#{random_string}#{random_integer}#{random_letter}"    
  end

end
