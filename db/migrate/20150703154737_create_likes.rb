class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|

    	t.string :topic_id
    	t.string :user_id
      t.timestamps null: false
    end
  end
end
