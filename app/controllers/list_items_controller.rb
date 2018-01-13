class ListItemsController < ApplicationController

	before_action :set_list_item, only: [:show, :restore, :destroy, :delete]

	def delete
		@list_item.delete
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Item Item was successfully destroyed.' }
	      format.json { head :no_content }
	    end		
	end

	def destroy
		@list_item.destroy
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Item Item was successfully destroyed.' }
	      format.json { head :no_content }
	    end	
	end

	def restore
		@list_item.undelete
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Item was successfully destroyed.' }
	      format.json { head :no_content }
	    end			
	end

	def show
		@tags = Tag.all
	end

	private

  def set_list_item
    @list_item = ListItem.find(params[:id])
  end
end
