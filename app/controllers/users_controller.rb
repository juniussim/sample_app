class UsersController < ApplicationController
  def new
		@user = User.new
  end

	def show
		#  debugger
	   @user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)    # Not the final implementation!
		if @user.save
			# Rails way to display a temporary message is to use a special method called the flash, which we can treat like a hash. Rails adopts the convention of a :success key for a message indicating a successful result
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
			# a clearer equivalent of the above (rails basically infers from redirect_to @user that we want to redirect to user_url(@user).)
			# redirect_to user_url(@user)
		else
			render 'new'
		end
	end

	private

	  def user_params
	    params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end

end
