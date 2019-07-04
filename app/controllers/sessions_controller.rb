class SessionsController < ApplicationController

	def new
	end

#flash[:notice]'s message will persist to the next action and should be used when redirecting to another action via the 'redirect_to' method
#Flash.now[:notice]'s message will be displayd in the view your are rendering via the 'render' method.
	def create 
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have successfully logged in"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "There was something wroing with your login information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out"
		redirect_to root_path
	end

end
