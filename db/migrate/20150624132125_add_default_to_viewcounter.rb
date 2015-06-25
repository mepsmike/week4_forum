class AddDefaultToViewcounter < ActiveRecord::Migration
  def change
  	change_column :topics, :view_counter, :integer, :default => 0
  end
end
