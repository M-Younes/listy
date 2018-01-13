class TagItemsController < ApplicationController

	before_action :set_tag_item, only: [:restore, :destroy, :delete]


	def create	
		list_item = ListItem.find(params[:id])
		tag = Tag.find(params[:tag_id])
		tag_item = list_item.tag_items.create(tag: tag)
		respond_to do |format|
		    if tag_item.save
		      flash[:notice] = "Tag was successfully assigned to #{list_item.name}."
		      format.html { redirect_to list_item }
		      format.json { render :show, status: :created, location: @tag_item }
		    else
		      format.html { render :new }
		      format.json { render json: @list.errors, status: :unprocessable_entity }
		    end
  		end		

	end

	def delete
		@tag_item.delete
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Tag was successfully destroyed.' }
	      format.json { head :no_content }
	    end		
	end

	def destroy
		@tag_item.destroy
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Tag Item was successfully destroyed.' }
	      format.json { head :no_content }
	    end	
	end

	def restore
		@tag_item.undelete
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Tag was successfully destroyed.' }
	      format.json { head :no_content }
	    end			
	end

	private

  def set_tag_item
    @tag_item = TagItem.find(params[:id])
  end

end
