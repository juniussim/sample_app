module SessionsHelper
	# this module has been included in the application controller
	# putting functions in helpers allow us to reuse these methods in all controllers as well as in all views, whereas only including it within a method in a controller causes the code not to be resu
	# Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

	# Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

	# Returns the current logged-in user (if any).
	def current_user
		# this is an assignment not a comparison -> we are assigning session[:user_id] to user_id and evaluating if its true or false
	 if (user_id = session[:user_id])
		 @current_user ||= User.find_by(id: user_id)
	 elsif (user_id = cookies.signed[:user_id])
		 user = User.find_by(id: user_id)
		 if user && user.authenticated?(cookies[:remember_token])
			 log_in user
			 @current_user = user
		 end
	 end
 end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		!current_user.nil?
	end

	# Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

	# Logs out the current user.
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
		# Setting @current_user to nil would only matter if @current_user were created before the destroy action (which it isn’t) and if we didn’t issue an immediate redirect (which we do). This is an unlikely combination of events, and with the application as presently constructed it isn’t necessary, but because it’s security-related I include it for completeness
	end

end
