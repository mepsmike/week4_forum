class Renamecolumntouser < ActiveRecord::Migration
  def change
  	rename_column :users, :provide, :provider
  end
end
