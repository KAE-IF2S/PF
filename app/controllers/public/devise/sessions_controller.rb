# frozen_string_literal: true

class Public::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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

  before_action :reject_user, only: [:create] #ログイン時に退会済みユーザか判定

  protected
    def reject_user
      @user = User.find_by(email: params[:user][:email].downcase)
      if @user
        if @user.active_for_authentication? == false #退会済みのとき
          flash[:notice] = '退会済みのユーザーです'
          redirect_to new_user_session_path
        end
      else
        flash[:notice] = "必須項目を入力してください。"
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
