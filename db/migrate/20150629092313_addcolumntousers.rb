class Addcolumntousers < ActiveRecord::Migration
  def change
  	add_column :users ,:provide, :string
  	add_column :users ,:uid,:string
  end
end
