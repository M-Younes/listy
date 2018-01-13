class AddDeletedAtToListAndListItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :lists, :deleted_at, :datetime
    add_column :list_items, :deleted_at, :datetime
  end  
end
