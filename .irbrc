def delete_and_reassign(user_id)
    deleted_user = User.find(user_id)
    target = deleted_user.target
    assassin = User.find_by(target: deleted_user.name)
    assassin.update_attribute(:target, target)
    User.delete(user_id)
end

def award_kill(user_id)
	deleted_user = User.find(user_id)
	target = deleted_user.target
	assassin = User.find_by(target: deleted_user.name)
	assassin.update_attribute(:target, target)
	User.delete(user_id)
	assassin.update_attribute(:num_of_kills, assassin.num_of_kills + 1)
end

