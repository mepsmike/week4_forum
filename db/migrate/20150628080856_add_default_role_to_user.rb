class AddDefaultRoleToUser < ActiveRecord::Migration
  def change
  	change_column :users, :role, :string, :default => :user1
  end
end
