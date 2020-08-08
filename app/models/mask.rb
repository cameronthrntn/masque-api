class Mask < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments

  validates_presence_of :design, :colour
end
