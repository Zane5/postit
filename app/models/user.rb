class User < ActiveRecord::Base
	include Sluggable

	has_many :posts
	has_many :comments
	has_many :votes

	
	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 3}

	sluggable_column :username

	def two_factor_auth?
		!self.phone.blank?
	end

	def generate_pin!
		self.update_column(:pin, rand(10 ** 6)) # randome 6 digit number
	end
 	
 	def remove_pin!
		self.update_column(:pin, nil)
	end

	def send_pin_to_twilio
		
	end

	def admin?
		self.role.to_s.to_sym == :admin
	end

	def moderator?
		self.role == 'moderator?'
	end
end