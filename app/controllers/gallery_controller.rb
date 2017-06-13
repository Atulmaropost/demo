class GalleryController < ApplicationController
	require 'roo'

	before_action :authenticate_user!	
	
	before_action :get_galleries, only: [:destroy, :index, :create, :update]
	before_action :get_gallery, only: [:update, :edit, :destroy]

	def index	

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


  def import_image
		response = Gallery.import(params[:file], current_user) 
		message_string = "#{response[:success]} files imported successfully.<br/>"
    message_string += "#{response[:failed]} files failed to import."
    debugger
    if response[:failed] > 0
      message_string += "<br /> Failed images detail:<br />"
      response[:failed_rows].each do |row|
        message_string += "Row Id: #{row.keys[0]} <br />"
        row[row.keys[0]].each do |message|
          message_string += message + "<br />"
        end
      end
    end
    debugger
    flash[:notice] = message_string
    redirect_to gallery_index_path
	end

	private 
	
	def get_gallery
		@gallery = Gallery.find(params[:id])
		
	end

	def get_galleries
		@user = current_user
		@galleries = current_user.galleries if current_user.galleries.present?
		@galleries= @galleries.order(:name).page(params[:page]).per(4) if @galleries.present?

	end

	def gallery_params

		params.require(:gallery).permit(:user_id , :name , :gallery_image)
	end

end
