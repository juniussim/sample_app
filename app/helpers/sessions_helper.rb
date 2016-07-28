module SessionsHelper
	# this module has been included in the application controller
	# putting functions in helpers allow us to reuse these methods in all controllers as well as in all views, whereas only including it within a method in a controller causes the code not to be resu
	# Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

	# Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		!current_user.nil?
	end

	# Logs out the current user.
	def log_out
		session.delete(:user_id)
		@current_user = nil
		# Setting @current_user to nil would only matter if @current_user were created before the destroy action (which it isn’t) and if we didn’t issue an immediate redirect (which we do). This is an unlikely combination of events, and with the application as presently constructed it isn’t necessary, but because it’s security-related I include it for completeness
	end

end
