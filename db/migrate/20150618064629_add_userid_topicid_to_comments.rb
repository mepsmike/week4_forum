class AddUseridTopicidToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :user_id, :integer
  	add_column :comments, :topic_id, :integer
  end
end
