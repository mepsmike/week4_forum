class AddColumnToTopic < ActiveRecord::Migration
  def change
  	add_column :topics, :like ,:integer
  end
end
