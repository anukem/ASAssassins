class AddNumOfKillsUsers < ActiveRecord::Migration
  def change
  	add_column :users, :num_of_kills, :int
  end
end
