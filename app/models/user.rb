class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 50},
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
					
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	validates :kill_code, presence: true, uniqueness: { case_sensitive: false}

	def increaseKillCount
		if self.num_of_kills == nil
			self.update_attribute(:num_of_kills, 1)
			print 111111111111111111111111111111111111111111111111111111111111
		else
			self.update_attribute(:num_of_kills, self.num_of_kills + 1)
		end
	end

end
