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

	def index
		@users = User.all 
	end

	def delete

		id = params[:id]
		killCode = params[:users][:kill_code]
		currentUser = User.find_by(id: id)
		killedUser = User.find_by(kill_code: killCode)
		boot_twilio
		from_number = ENV["from_number"]
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
				oldTargetName = currentUser.target 
				newTarget = currentUser.select_new_target(currentUser, @killedUser)
				if killedUser.name == oldTargetName 
    				@killedUser = killedUser
    				@client.account.messages.create({
					:from => from_number, 
					:to => currentUser.phone_number, 
					:body => 'Well done. You killed '+ killedUser.name + 
							 '. Your next target is ' + newTarget + "." ,  
					})

					#For the killers next target 
					@client.account.messages.create({
					:from => from_number, 
					:to => "8178915039", #newTarget.phone_number 
					:body => 'Your assassin has been killed, be careful.' 
					})
					
    			else
    				#For the killer
    				@client.account.messages.create({
					:from => from_number, 
					:to => "8178915039",#currentUser.phone_number 
					:body => 'Well done. Your kill has been recorded.' 
					})

    				#For the killers next target 
					@client.account.messages.create({
					:from => from_number, 
					:to => "8178915039", #newTarget.phone_number 
					:body => 'Your assassin has been killed, be careful.' 
					})
    			end
				redirect_to currentUser

			end
		end
		
	end

	def textToKill
    	
    	from_number = params[:From]
    	from_number = from_number[2,from_number.length - 1]
    	potentialKillCode = params[:Body]

    	killer = User.find_by(phone_number: from_number)
    	killedUser = User.find_by(kill_code: potentialKillCode)
    	if killer 
    		if killedUser

    			if killedUser.name == killer.target
    				@killedUser = killedUser
    				killer.select_new_target(killer, killedUser)
    				render "killedTarget", :content_type => "text/xml"
    			else
    				if killedUser.name == killer.name 
    					render "failure", :content_type => "text/xml"
    				else
    					@killedUser = killedUser
    					killer.select_new_target(killer, killedUser)
    					render "anarchyKill", :content_type => "text/xml"
    				end
    			end

    		else
    			render "failure", :content_type => "text/xml"
    		end
    		
    	else
    		render "failure", :content_type => "text/xml"
    	end
	end

	private 

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number)
	end

	def boot_twilio
    	account_sid = Figaro.env.ACCOUNT_SID
    	auth_token = Figaro.env.AUTH_TOKEN
    	@client = Twilio::REST::Client.new account_sid, auth_token
  	end

	def generate_random_string

		num = Random.new
		newNum = num.rand(1000)
		return newNum
		
	end
end
