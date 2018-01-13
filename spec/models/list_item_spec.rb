require 'rails_helper'

RSpec.describe ListItem, type: :model do
	  describe ListItem do
	  	before(:each) do
	  	 @list = FactoryBot.create(:list)
	  	 @deleted_list = FactoryBot.create(:list, name: "List name", deleted_at: DateTime.current )
	  	 @list_item = FactoryBot.create(:list_item, name: "list item name", list_id: @list.id)
	  	 @deleted_list_item = FactoryBot.create(:list_item, name: "list item name", list_id: @list.id, deleted_at: DateTime.current )
	  	 @tag = FactoryBot.create(:tag)
	  	end
		  it "has a valid factory" do
		    @list_item.should be_valid
		  end
		  it "is invalid without a name" do 
		  	FactoryBot.build(:list_item, name: nil).should_not be_valid
		  end
		  it "is invalid without a list it" do 
		  	FactoryBot.build(:list_item, name: "list item", list_id: nil).should_not be_valid
		  end		  
		  it "Should fill in deleted_at" do
		  	@list_item.delete
		  	@list_item.deleted_at.should_not equal?(nil)
		  end
		  it "Should fill in deleted_at for list tag item" do
		  	tag_item = FactoryBot.create(:tag_item, list_item_id: @list_item.id, tag_id: @tag.id)
		  	@list_item.delete
		  	tag_item.deleted_at.should_not equal?(nil)
		  end
		  it "Should restore list item" do
		  	@deleted_list_item.undelete
		  	@deleted_list_item.deleted_at.should equal?(nil)
		  end
		  it "Should restore tag items" do
		  	tag_item = FactoryBot.create(:tag_item, list_item_id: @deleted_list_item.id, tag_id: @tag.id, deleted_at: DateTime.current)
		  	@deleted_list_item.undelete
		  	tag_item.deleted_at.should equal?(nil)
		  end			  	   
	end
end
