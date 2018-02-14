class MakeNumOfKillsAnInteger < ActiveRecord::Migration
  def change
	change_column :users, :num_of_kills, null: false
  end
end
