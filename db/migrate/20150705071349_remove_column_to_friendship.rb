class RemoveColumnToFriendship < ActiveRecord::Migration
  def change
  	remove_column :friendships ,:destroy
  	remove_column :friendships ,:create
  end
end
