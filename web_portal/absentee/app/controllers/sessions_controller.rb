class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    Rails.logger.info("params -------- #{params}")
    user = User.where(email: params[:session][:email]).first
    if user and user.valid_password?(params[:session][:password])
      respond_to do |format|
        token = user.get_auth_token
        format.json { render json: {data: { auth_token: token,
          message: I18n.t('session.create.success')} }, status: 201 }
      end
    else
      respond_to do |format|
        format.json { render json: {error: { message: I18n.t('session.create.failure')} }, status: 401 }
      end
    end
  end

  def destroy
    user = User.where(auth_token: request.headers['Authorization']).first
    if user and user.delete_auth_token
      respond_to do |format|
        format.json { render json: {message: I18n.t('session.destroy.success')}, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: {message: I18n.t('session.destroy.failure')}, status: 200 }
      end
    end
  end
end
