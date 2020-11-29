class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :require_sign_in!

  private

  def require_sign_in!
    redirect_to login_path unless logged_in?
  end
end
