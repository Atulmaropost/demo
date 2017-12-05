class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create	
  	@password = User.generate_password
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    
    if resource.persisted?
      #RegistrationWorker.perform(resource.email, @password)
      ContactMailer.welcome_email(resource.email, @password).deliver

      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_to do |format|
          format.html { respond_with resource, location: after_sign_up_path_for(resource) }
          format.json { render json: { status: "Success", message: "Successful", code: 200 } }
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_to do |format|
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
          format.json { render json: { status: "Success", message: "Successful, please activate account", code: 200 } }
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
          format.html { respond_with resource }
          format.json { render json: { status: "Failure", message: resource.errors.full_messages, code: 500 } }
        end
    end
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end




   protected

     def build_resource(hash=nil)
      hash = hash.merge({password: @password, password_confirmation: @password})
      super(hash)
    end



    def after_sign_up_path_for(resource)
      new_user_session_path
    end

    def after_inactive_sign_up_path_for(resource)
      new_user_session_path
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

