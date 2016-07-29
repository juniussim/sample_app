class User < ApplicationRecord
	attr_accessor :remember_token
	before_save { self.email = self.email.downcase }
	# To avoid this incompatibility, we’ll standardize on all lower-case addresses, converting “Foo@ExAMPle.CoM” to “foo@example.com” before saving it to the database. The way to do this is with a callback, which is a method that gets invoked at a particular point in the lifecycle of an Active Record object. In the present case, that point is before the object is saved, so we’ll use a before_save callback to downcase the email attribute before saving the user.
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	# Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	# Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

	# Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(self.remember_token))
  end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		# this is to ensure that you do not call .is_password with nil which will throw an error
		return false if remember_digest.nil?
		# taking the browser token -> hashing it -> and then comparing it with the hashed token stored in the database
		BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
 	def forget
	 	self.update_attribute(:remember_digest, nil)
 	end


end
