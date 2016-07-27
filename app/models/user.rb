class User < ApplicationRecord
	before_save { self.email = self.email.downcase }
	# To avoid this incompatibility, we’ll standardize on all lower-case addresses, converting “Foo@ExAMPle.CoM” to “foo@example.com” before saving it to the database. The way to do this is with a callback, which is a method that gets invoked at a particular point in the lifecycle of an Active Record object. In the present case, that point is before the object is saved, so we’ll use a before_save callback to downcase the email attribute before saving the user.
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
