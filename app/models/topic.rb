class Topic < ApplicationRecord
  belongs_to :user
  has_many :masks, dependent: :destroy
  has_many :users, through: :masks

  validates_presence_of :title
end
