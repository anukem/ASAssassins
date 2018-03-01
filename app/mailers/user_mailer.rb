class UserMailer < ApplicationMailer
	default from: "cu.asassassins@gmail.com"
	
	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: "Welcome to my awesome site!")
	end
end
