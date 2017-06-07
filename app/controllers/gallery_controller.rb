class GalleryController < ApplicationController

	before_action :authenticate_user!	
	
	before_action :get_galleries, only: [:destroy, :index]
	before_action :get_gallery, only: [:update, :edit, :destroy]

	def index

	end

	def create			
		@gallery =  Gallery.create(gallery_params)
		respond_to do |format|
	  	if @gallery.save
	    	format.html { redirect_to about_us_path, notice: 'Gallery was successfully Send.' }
	  	else
	    	
	    	format.html { redirect_to about_us_path, notice: 'Gallery was not created please try with different name.' }
	  	end
		end
	end

	def edit
	
	end


	def update
	  if @gallery.update(gallery_params)
	    redirect_to about_us_path
	  else
	      redirect_to about_us_path
	  end
	end
		


	def destroy
	   @gallery.destroy
	    respond_to do |format|
          format.js { render :layout=>false }
      end
  end 

	private 
	def get_gallery
		@gallery = Gallery.find(params[:id])
		
	end

	def get_galleries
		@user = current_user
		@galleries = current_user.galleries
	end

	def gallery_params

		params.require(:gallery).permit(:user_id , :name , :gallery_image)
	end

end
