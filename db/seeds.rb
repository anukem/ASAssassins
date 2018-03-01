# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "John Anukem", email: "jea2161@columbia.edu", 
			password: "doggie", password_confirmation: "doggie", 
			kill_code: "123", num_of_kills: 0, target: "Braxton Gunter", phone_number: "8178915039")

User.create(name: "Braxton Gunter", email: "beg2119@columbia.edu", 
			password: "doggie", password_confirmation: "doggie", 
			kill_code: "1", num_of_kills: 0, target: "Fredrick Kofi Tam", phone_number: "2419762371")

User.create(name: "Fredrick Kofi Tam", email: "fkt2105@columbia.edu", 
			password: "doggie", password_confirmation: "doggie", 
			kill_code: "2", num_of_kills: 0, target: "John Anukem", phone_number: "4106557997")

# original_name = "John"
# original_password = "doggie"
# original_password_confirmation = "doggie"
# original_kill_code = "123"
# num_of_kills = 0
# target = ""
# original_phone_number = "0000000000"
# for i in 1..100
# 	@name = original_name + " D" + i.to_s
# 	@email = "jam" + i.to_s + "@jam.com"
# 	@password = original_password
# 	@password_confirmation = original_password
# 	@kill_code = i.to_s
# 	@target = target + i.chr 
# 	@phone_number = (i + 1000000000).to_s

# 	print(User.create(name: @name, email: @email, password: 
# 		@password, password_confirmation: @password_confirmation,
# 		kill_code: @kill_code, num_of_kills: 0, 
# 		target: @target, phone_number: @phone_number).errors.messages)
# end

