class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user
  	elsif !user
  		flash.now[:danger] = "Email not found"
      puts 1
  		render "new"
  	else
  		flash.now[:danger] = "Invald email/password combination"
  		render "new"	
  	end
  	
  end

  def destroy
  	log_out
    redirect_to root_url
  end
end
