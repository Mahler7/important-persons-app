class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def create

    @user = User.new({
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone_number: params[:phone_number]
      })

  end

  def edit

    @user = User.find(params[:id])

  end

  def update

    @user = User.find(params[:id])

    user.update({
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone_number: params[:phone_number]
    })

  end

end
