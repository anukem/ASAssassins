class ChangeNumOfKillsToNonNull < ActiveRecord::Migration
  def change
	change_column_null :users, :num_of_kills, false
	
  end
end
