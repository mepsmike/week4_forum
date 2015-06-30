class AddColToTopics < ActiveRecord::Migration
  
  def change
  	add_column :topics, :comments_count, :integer, :default => 0
  	add_column :topics, :last_commented_at, :datetime

  	Topic.all.each do |p|
  		p.comments_count = p.comments.count
  		p.last_commented_at = p.comments.order("id DESC").first.try(:updated_at)
  		p.save
  	end

  end

end
