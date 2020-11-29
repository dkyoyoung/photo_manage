class User < ApplicationRecord
  has_many :photos
  has_one :auth
end
