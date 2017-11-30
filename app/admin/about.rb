ActiveAdmin.register About do
	
 menu label:  "About_us"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model

 permit_params :heading, :image, :description
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

    form  do |f|
		f.inputs "About_us" do
         	f.input :heading
 		 	f.input :image, as: :file
   		 	f.input :description
  	    end
  	f.actions
	end

end
