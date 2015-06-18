class AddIndexToTables < ActiveRecord::Migration
  def change
  	  add_index :topics, :user_id
  	  add_index :comments, :user_id
  	  add_index :comments, :topic_id
  	  add_index :topic_categoryships, :topic_id
  	  add_index :topic_categoryships, :category_id
  end
end
