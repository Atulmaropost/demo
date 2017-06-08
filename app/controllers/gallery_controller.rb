class GalleryController < ApplicationController

	before_action :authenticate_user!	
	
	before_action :get_galleries, only: [:destroy, :index, :create, :update]
	before_action :get_gallery, only: [:update, :edit, :destroy]

	def index

	end


	def new
		@gallery = Gallery.new(gallery_params)
	end

	def create			
		@gallery =  Gallery.create(gallery_params)
	  @gallery.save
	end

	def edit
	
	end


	def update
	   @gallery.update(gallery_params)
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
		@galleries = current_user.galleries if current_user.galleries.present?
		@galleries= @galleries.order("DESC").page(params[:page]).per(4) if @galleries.present?

	end

	def gallery_params

		params.require(:gallery).permit(:user_id , :name , :gallery_image)
	end

end
