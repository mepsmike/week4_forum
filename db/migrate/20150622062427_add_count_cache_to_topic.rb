class AddCountCacheToTopic < ActiveRecord::Migration
  def change
  	add_column :topics, :users_count, :integer
  end
end
