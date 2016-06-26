class AddKillCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kill_code, :string
  end
end
