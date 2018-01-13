require 'rails_helper'

RSpec.describe List, type: :model do

	  describe List do
	  	before(:each) do 
	  	 @list = FactoryBot.create(:list)
	  	 @deleted_list = FactoryBot.create(:list, name: "list name", deleted_at: DateTime.current )
	  	end
		  it "has a valid factory" do
		    @list.should be_valid
		  end
		  it "is invalid without a name" do 
		  	FactoryBot.build(:list, name: nil).should_not be_valid
		  end
		  it "Should fill in deleted_at" do
		  	@list.delete
		  	@list.deleted_at.should_not equal?(nil)
		  end
		  it "Should fill in deleted_at for list item" do
		  	list_item = FactoryBot.create(:list_item, name: "list item", list_id: @list.id)
		  	@list.delete
		  	list_item.deleted_at.should_not equal?(nil)
		  end
		  it "Should restore list" do
		  	@deleted_list.undelete
		  	@deleted_list.deleted_at.should equal?(nil)
		  end
		  it "Should restore list items" do
		  	list_item = FactoryBot.create(:list_item, name: "list item", list_id: @deleted_list.id, deleted_at: DateTime.current)
		  	@deleted_list.undelete
		  	list_item.deleted_at.should equal?(nil)
		  end		  	   
	end
end