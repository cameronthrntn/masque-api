class Comment < ApplicationRecord
  belongs_to :mask

  validates_presence_of :content
end
