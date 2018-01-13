class ListsController < ApplicationController
	before_action :set_list, only: [:show, :edit, :update, :destroy, :delete, :restore]

	def index
		@lists = List.not_destroyed
	end

	def new
		@list = List.new
	end

	def create
		@list = List.new(list_params)
		respond_to do |format|
		    if @list.save
		      flash[:notice] = 'List was successfully created.'
		      format.html { redirect_to root_path }
		      format.json { render :show, status: :created, location: @list }
		    else
		      format.html { render :new }
		      format.json { render json: @list.errors, status: :unprocessable_entity }
		    end
  		end
	end

	def update
	    respond_to do |format|
	      if @list.update_attributes(list_params)
	        format.html { redirect_to root_path, notice: 'List was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @list.errors, status: :unprocessable_entity }
	      end
	    end		
	end

	def delete
		@list.delete
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'List was successfully destroyed.' }
	      format.json { head :no_content }
	    end		
	end

	def destroy
		@list.destroy
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'List was successfully destroyed.' }
	      format.json { head :no_content }
	    end	
	end

	def restore
		@list.undelete
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'List was successfully destroyed.' }
	      format.json { head :no_content }
	    end			
	end 

	def trash
		@destroyed_lists = List.destroyed
		@destroyed_items = ListItem.destroyed_items
		@destroyed_tags = TagItem.destroyed_items
	end

	private

  def set_list
    @list = List.find(params[:id])
  end

	def list_params
		params.fetch(:list).permit(:name, list_items_attributes:[:name, :_destroy])
	end
end
