class User < ApplicationRecord
  has_many :masks, dependent: :destroy
  has_many :topics, through: :masks, dependent: :destroy

  validates_presence_of :access
end
