class UsersController < ApplicationController

	def show
		seshID =  session[:user_id].to_s
		id = params[:id].to_s
		if seshID == id
			@user = User.find(params[:id])		
		else
			redirect_to root_url
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.kill_code = generate_random_string
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the time of your life!"
			@user.begin_game
			redirect_to @user
		
		elsif !@user.save && User.find_by(kill_code: @user.kill_code)
			while User.find_by(kill_code: @user.kill_code)
				@user.kill_code = generate_random_string
			end
			@user.save
			log_in @user
			flash[:success] = "Welcome to the time of your life!"
			redirect_to @user
		else
			render "new"
		end
	end

	def delete

		id = params[:id]
		killCode = params[:users][:kill_code]
		currentUser = User.find_by(id: id)
		killedUser = User.find_by(kill_code: killCode)
		if currentUser == killedUser	
			@user = User.find_by(id: id)
			flash[:danger] = "Sorry, you can't kill yourself"
			redirect_to @user
		else
			@killedUser = User.find_by(kill_code: killCode)
			if @killedUser == nil
				flash[:danger] = "Wrong Code"
				redirect_to currentUser
			else
				targetName = currentUser.select_new_target(currentUser, @killedUser)
				# put your own credentials here 
				account_sid = 'ACd90d6846a29ce128e98bee5f07e1de0d' 
				auth_token = '0fe6761da942613b979401cadc61d670' 
				 
				# set up a client to talk to the Twilio REST API 
				@client = Twilio::REST::Client.new account_sid, auth_token 
				 
				@client.account.messages.create({
					:from => '+16822171741', 
					:to => '8178915039', 
					:body => 'Your next target is ' + targetName ,  
				})
				redirect_to currentUser

			end
		end
		
	end

	private 

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def generate_random_string

		num = Random.new
		newNum = num.rand(1000)
		return newNum
		
	end
end
