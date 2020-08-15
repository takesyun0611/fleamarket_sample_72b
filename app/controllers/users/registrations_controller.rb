# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    # sns認証で新規登録時
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      @user.password = pass
      @user.password_confirmation = pass
      if @user.valid? == false
        render :new
      else
        session["devise.regist_data"] = {user: @user.attributes}
        session["devise.regist_data"][:user]["password"] = params[:user][:password]
        @shipment = @user.shipments.build
        render :new_shipment
      end
    # メールアドレスで新規登録時
    elsif @user.valid? == false
      render :new
    else
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      @shipment = @user.shipments.build
      render :new_shipment
    end
  end

  def create_shipment
    @user = User.new(session["devise.regist_data"]["user"])
    @shipment = Shipment.new(shipment_params)
    if @shipment.valid? == false
      session["devise.regist_data"][:user] = session["devise.regist_data"]["user"]
      render :new_shipment
    else
      @user.shipments.build(@shipment.attributes)
      @user.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
      render :create_shipment
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

  # protected

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

  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :family_name, :given_name, :family_name_kana, :given_name_kana, :birthday, :phone_number, :intro)
  end

  def shipment_params
    params.require(:shipment).permit(:family_name, :given_name, :family_name_kana, :given_name_kana, :postal_code, :prefecture, :city, :house_number, :building_name, :room_number, :phone_number)
  end
end
