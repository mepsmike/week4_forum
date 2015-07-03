class CreateTopicTagships < ActiveRecord::Migration
  def change
    create_table :topic_tagships do |t|
      t.integer :topic_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
