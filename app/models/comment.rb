class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :content, presence: true
  def to_s
    content
  end
end
