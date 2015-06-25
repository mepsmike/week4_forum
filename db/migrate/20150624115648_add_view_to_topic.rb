class AddViewToTopic < ActiveRecord::Migration
  def change
  	add_column :topics, :view_counter, :integer
  end
end
