class Answer < ApplicationRecord
  acts_as_votable
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tags, as: :taggable

end
