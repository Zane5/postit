 class SessionsController < ApplicationController
 	def new

 	end

 	def create
 		# ex user.authenticate('password')
 		# 1. get the user obj
 		# 2. see if password matches
 		# 3. if so. log in
 		# 4. if not, error message

 		user = User.find_by(username: params[:username])
 		#user = User.where(username: params[:username])
 		#binding.pry
 		if user && user.authenticate(params[:password])
 			if user.two_factor_auth?
 				session[:two_factor] = true
 				# gen a pin
 				user.generate_pin!
 				# send pin to twlio, sms to user's phone
 				# show pin form
 				user.send_pin_to_twilio
 				redirect_to pin_path
 			else
 				login_user!(user)
	 		end
 		else
 			flash[:error] = "There's something wrong with your username or password."
 			redirect_to register_path
 		end
 		 

 	end

 	def destroy
 		session[:user_id] = nil
 		flash[:notice] = "You've logged out!"
 		redirect_to root_path
 	end

 	def pin

 		access_denied if session[:two_factor].nil?

 		if request.post?
 			user = User.find_by pin: params[:pin]
 			if user
 				# remove pin
 				session[:two_factor] = nil
 				user.remove_pin!
 				# normal login success
 				login_user!(user)
 			else
 				flash[:error] = "Sorry, something is wrong with your pin number."
 				redirect_to pin_path
 			end
 		end
 	end

 	private
 		def login_user!(user)
			session[:user_id] = user.id
			flash[:notice] = "You've logged in!" 
 			redirect_to root_path
 		end
 end