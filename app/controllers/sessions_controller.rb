class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  before_action :get_new_user, only: [:new, :create]

  def new
  end

  def create
    if params[:session][:user_id].present?
      if User.find_by_user_id(params[:session][:user_id])
        @user = User.find_by_user_id(params[:session][:user_id])
      else
        @user.errors.add(:no_user, "ユーザーが存在しません")
      end
    else
      @user.errors.add(:user_id, "を入力してください")
    end

    if params[:session][:password].present?
      @user.errors.add(:no_password, "パスワードが間違ってる") unless @user.password == params[:session][:password]
    else
      @user.errors.add(:password, "を入力してください")
    end
 
    unless @user.errors.present?
      log_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def get_new_user
    @user ||= User.new
  end

  def logged_in_user
    unless logged_in?
      redirect_to login_path 
    end
  end
end
