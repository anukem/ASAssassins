def delete_and_reassign(user_id)
    deleted_user = User.find(user_id)
    target = deleted_user.target
    assassin = User.find_by(target: deleted_user.name)
    assassin.update_attribute(:target, target)
    User.delete(user_id)
end