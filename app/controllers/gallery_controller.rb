class GalleryController < ApplicationController
	require 'roo'

	#before_action :authenticate_user!	
	
	before_action :get_galleries, only: [:destroy, :index,:create, :update ,:import_image]
	before_action :get_gallery, only: [:update, :edit, :destroy]

	def index	
		if request.format.json?
			respond_to do |format|
				if @galleries.present?
				 format.json { 
		        render json: { 
		          status: "Success",
		          message: "Successful",
		          data: {name: @galleries},
		          code: 200 
		        } 
		     }   
		    else
		    	format.json { render json: { status: "Failure", message: "No image found", code: 500 } }
		    end	   
		  end  
		end 
	end


	def create	
		if request.format.json?
			@gallery =   Gallery.new(name: params[:gallery][:name], remote_gallery_image_url: params[:gallery][:gallery_image], user_id: current_user)
		 	respond_to do |format| 
			 	 if @gallery.save
	        format.json { render json: { status: "Success", message: "Successful", code: 200 } }
			 	 else
	        format.json { render json: { status: "Failure", message: @gallery.errors.full_messages, code: 500 } }
			 	 end
			end 
		else
			@gallery =  Gallery.create(gallery_params)
		end		 
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

  def get_image
	 if params[:id].match(/\A\d+\z/i).blank? # means it does have some non numeric character
    message = "Image id can be numeric only"
    respond_to do |format|
      format.html { redirect_to gallery_index_path, notice: message }
      format.json { render json: { status: "Failure", message: message, code: 500 } }
    end
  else
    @gallery = Gallery.find_by_id(params[:id])

    respond_to do |format|
      if @gallery.present?
        format.html
        format.json { 
          render json: { 
            status: "Success",
            message: "Successful",
            data: {name: @gallery.name, url: request.protocol + request.host_with_port + @gallery.image_url},
            code: 200 
          } 
        }
      else
        format.html { redirect_to gallery_index_path, notice: "No image found" }
        format.json { render json: { status: "Failure", message: "No image found", code: 500 } }
      end
    end
  end
  	
  end


  def gallery_count
  	sleep(2);
  	@gallery_count =  current_user.galleries.size
  	respond_to do |format|
  		format.js
  	end	
  end



  def import_image
		response = Gallery.import(params[:file], current_user) 
 		unless response[:error_message].present?
			message_string = "#{response[:success]} files imported successfully.<br/>"
	    message_string += "#{response[:failed]} files failed to import."
	    if response[:failed] > 0
	      message_string += ""
	      response[:failed_rows].each do |row|
	        message_string += "Row Id: #{row.keys[0]} <br />"
	        row[row.keys[0]].each do |message|
	          message_string += message + "<br />"
	        end
	      end
	    end
	    flash[:notice] = message_string
    	redirect_to gallery_index_path
	  else
	  	@gallery = Gallery.new
      flash.now[:error] = response[:error_message]
      render :index
    end	
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
