require 'net/https'

class PhotoManageController < ApplicationController
  layout 'logout'
  before_action :get_new_photo, only: [:new, :create]
  before_action :get_photos, only: [:index]
  before_action :get_auth, only: [:index, :callback, :tweets]

  def index
  end

  def new
  end

  def oauth
    client_id = ""
    redirect_to "https://arcane-ravine-29792.herokuapp.com/oauth/authorize?client_id=#{client_id}&response_type=code&redirect_uri=http://localhost:3000/oauth/callback"
  end

  def callback
    url = "https://arcane-ravine-29792.herokuapp.com/oauth/token"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.path)

    client_id = ""
    client_secret = ""

    req.set_form_data({
        "code" => params["code"],
        "client_id" => client_id,
        "client_secret" => client_secret,
        "redirect_uri" =>  "http://localhost:3000/oauth/callback",
        "grant_type" => "authorization_code",
      }
    )

    res = http.request(req)

    @auth.update_attributes(token: JSON.parse(res.body)["access_token"])

    redirect_to root_url
  end

  def create
    if @photo.update_attributes(permit_params)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def tweets
    url = "https://arcane-ravine-29792.herokuapp.com/api/tweets"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.path)

    req["Authorization"] = "bearer #{@auth.token}"
    req["Content-Type"] = "application/json"

    photo = Photo.find(params[:photo_id])

    data = {
      "text": photo.title,
      "url": "http://localhost:3000#{photo.image.url}"
    }.to_json

    req.body = data

    http.request(req)

    redirect_to root_url
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

  def get_auth
    @auth = current_user.auth || current_user.create_auth
  end
end
