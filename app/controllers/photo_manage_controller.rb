class PhotoManageController < ApplicationController
  layout 'logout'
  before_action :get_new_photo, only: [:new, :create]
  before_action :get_photos, only: [:index]

  def index
  end

  def new
  end

  def create
    if @photo.update_attributes(permit_params)
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def permit_params
    params.require(:photo).permit(:image, :title)
  end

  def get_new_photo
    @photo ||= current_user.photos.new
  end

  def get_photos
    @photos = current_user.photos
  end
end
