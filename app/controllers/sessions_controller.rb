class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_user_id(params[:session][:user_id])
    if user && user.password == params[:session][:password]
      log_in user
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

  def logged_in_user
    unless logged_in?
      redirect_to login_path 
    end
  end
end
