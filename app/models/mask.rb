class Mask < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates_presence_of :mask, :colour
end
