class ReviseFavorite < ActiveRecord::Migration
  def change
  	rename_column :favorites, :post_id, :topic_id
  end
end
